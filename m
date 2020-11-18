Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BCA2B8300
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgKRRTC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:19:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56288 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgKRRS1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:27 -0500
Date:   Wed, 18 Nov 2020 17:18:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D8nvGAloLJJ+ql8yUirlpnKjefPIphkSY9wZqt7KbrU=;
        b=HmXLRPvL6PMY28DoLg8vFxmeMzLmDS/aanFDrDA0oHMsTV0kFY2TOMoz+uE89FHthZwDMm
        UsoYbrgWzukpzd20d2fqUbL/0+IflPX/17U8Oih0IJfb5rH9oJBZdCrKtupnd3p0bTLR4Y
        eBRQ2ecI/5ECsT6YEIzCPgycjWE3fm4kXb7ky2eKX1FOyMNg2k83e+0RdG46q5Y3h7BpMI
        g4g9zjhsrpopCMTFnJgyiyOnxxYpiVIgIYJK5lnPU6gPiw4X7Xt5+hEFlvoJAOV1YkyBl0
        c1KUsEj5Fl5QgHm2i9zpzng31rKERTbn7rEha0QYEIdOUw9LJkbYJvqbvC1R5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D8nvGAloLJJ+ql8yUirlpnKjefPIphkSY9wZqt7KbrU=;
        b=uOgaBK5vemufPZWUYT3IMXINBNMLwhm00NKsUyMuSTibbrQKJWLHEhQ2Jv5isvjWNOh0Un
        Xp9W/wmlEYr5dnCQ==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] mm: Add 'mprotect' hook to struct vm_operations_struct
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hillf Danton <hdanton@sina.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-11-jarkko@kernel.org>
References: <20201112220135.165028-11-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571990472.11244.16622523428160178953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     95bb7c42ac8a94ce3d0eb059ad64430390351ccb
Gitweb:        https://git.kernel.org/tip/95bb7c42ac8a94ce3d0eb059ad644303903=
51ccb
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 13 Nov 2020 00:01:21 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Nov 2020 14:36:14 +01:00

mm: Add 'mprotect' hook to struct vm_operations_struct

Background
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. SGX enclave pages are populated with data by copying from normal memory
   via ioctl() (SGX_IOC_ENCLAVE_ADD_PAGES), which will be added later in
   this series.
2. It is desirable to be able to restrict those normal memory data sources.
   For instance, to ensure that the source data is executable before
   copying data to an executable enclave page.
3. Enclave page permissions are dynamic (just like normal permissions) and
   can be adjusted at runtime with mprotect().

This creates a problem because the original data source may have long since
vanished at the time when enclave page permissions are established (mmap()
or mprotect()).

The solution (elsewhere in this series) is to force enclave creators to
declare their paging permission *intent* up front to the ioctl().  This
intent can be immediately compared to the source data=E2=80=99s mapping and
rejected if necessary.

The =E2=80=9Cintent=E2=80=9D is also stashed off for later comparison with en=
clave
PTEs. This ensures that any future mmap()/mprotect() operations
performed by the enclave creator or done on behalf of the enclave
can be compared with the earlier declared permissions.

Problem
=3D=3D=3D=3D=3D=3D=3D

There is an existing mmap() hook which allows SGX to perform this
permission comparison at mmap() time.  However, there is no corresponding
->mprotect() hook.

Solution
=3D=3D=3D=3D=3D=3D=3D=3D

Add a vm_ops->mprotect() hook so that mprotect() operations which are
inconsistent with any page's stashed intent can be rejected by the driver.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Hillf Danton <hdanton@sina.com>
Cc: linux-mm@kvack.org
Link: https://lkml.kernel.org/r/20201112220135.165028-11-jarkko@kernel.org
---
 include/linux/mm.h | 7 +++++++
 mm/mprotect.c      | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index db6ae4d..1813fa8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -559,6 +559,13 @@ struct vm_operations_struct {
 	void (*close)(struct vm_area_struct * area);
 	int (*split)(struct vm_area_struct * area, unsigned long addr);
 	int (*mremap)(struct vm_area_struct * area);
+	/*
+	 * Called by mprotect() to make driver-specific permission
+	 * checks before mprotect() is finalised.   The VMA must not
+	 * be modified.  Returns 0 if eprotect() can proceed.
+	 */
+	int (*mprotect)(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end, unsigned long newflags);
 	vm_fault_t (*fault)(struct vm_fault *vmf);
 	vm_fault_t (*huge_fault)(struct vm_fault *vmf,
 			enum page_entry_size pe_size);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 56c02be..ab70902 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -616,9 +616,16 @@ static int do_mprotect_pkey(unsigned long start, size_t =
len,
 		tmp =3D vma->vm_end;
 		if (tmp > end)
 			tmp =3D end;
+
+		if (vma->vm_ops && vma->vm_ops->mprotect)
+			error =3D vma->vm_ops->mprotect(vma, nstart, tmp, newflags);
+		if (error)
+			goto out;
+
 		error =3D mprotect_fixup(vma, &prev, nstart, tmp, newflags);
 		if (error)
 			goto out;
+
 		nstart =3D tmp;
=20
 		if (nstart < prev->vm_end)
