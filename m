Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9AA451D35
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 01:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351214AbhKPA0A (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 19:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344324AbhKOUe7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:34:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76270C043196;
        Mon, 15 Nov 2021 12:22:33 -0800 (PST)
Date:   Mon, 15 Nov 2021 20:22:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637007748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GzxNyqL2Z/uVnf/a5zfHz6ROPmll72UPWyN6lMx/XsI=;
        b=Hxi8Ob3J9QxNPv7v1bWKwv0CjHUKlSkWiKTVSE3NxIv8fvRUYLDojVY6hSEQ0EEmrH/wS7
        fcmjYQ0bhSVjEtBFxS6miae85i21wCbEh83TlS/J0+1k1l38K8w1NTy/+pZJLEW+xeGgJ/
        LeP67v85ZK2S62JOaVcI6lp0nc70rZG6YJuhIxp6yu2pe4rvI7K+DtSAdFnQPJj8nmC8Ah
        QxyO9Cqb+4i2rh+c7pIds7/8SGtFW5/DUeSWvZ1ssJ4dma6FpFSgj7XumsdPUDpb2lomKv
        ZVk176+pvWkhPUx5P4G7ybMJksFaOZjb8ITAoVttVYPq23wkjmzpdS53mrHj7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637007748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GzxNyqL2Z/uVnf/a5zfHz6ROPmll72UPWyN6lMx/XsI=;
        b=P4DznWhOz9n23oEia5E/c6DdMgVSDdh741psZjC41vvTCcJbWrmoLhmXHt42MoR/tRrdMA
        p7J2KbwuKHJL7FDw==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Make data measurement for an enclave
 segment optional
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C625b6fe28fed76275e9238ec4e15ec3c0d87de81=2E16369?=
 =?utf-8?q?97631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C625b6fe28fed76275e9238ec4e15ec3c0d87de81=2E163699?=
 =?utf-8?q?7631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <163700774718.414.7220232392030659637.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     5f0ce664d8c6c160ce4333e809545a8a57fe2baf
Gitweb:        https://git.kernel.org/tip/5f0ce664d8c6c160ce4333e809545a8a57fe2baf
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Mon, 15 Nov 2021 10:35:16 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 11:34:01 -08:00

selftests/sgx: Make data measurement for an enclave segment optional

For a heap makes sense to leave its contents "unmeasured" in the SGX
enclave build process, meaning that they won't contribute to the
cryptographic signature (a RSA-3072 signed SHA56 hash) of the enclave.

Enclaves are signed blobs where the signature is calculated both from
page data and also from "structural properties" of the pages.  For
instance a page offset of *every* page added to the enclave is hashed.

For data, this is optional, not least because hashing a page has a
significant contribution to the enclave load time. Thus, where there is
no reason to hash, do not. The SGX ioctl interface supports this with
SGX_PAGE_MEASURE flag. Only when the flag is *set*, data is measured.

Add seg->measure boolean flag to struct encl_segment. Only when the
flag is set, include the segment data to the signature (represented
by SIGSTRUCT architectural structure).

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/625b6fe28fed76275e9238ec4e15ec3c0d87de81.1636997631.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/load.c      | 6 +++++-
 tools/testing/selftests/sgx/main.h      | 1 +
 tools/testing/selftests/sgx/sigstruct.c | 6 ++++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 5605474..f1be789 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -111,7 +111,10 @@ static bool encl_ioc_add_pages(struct encl *encl, struct encl_segment *seg)
 	ioc.offset = seg->offset;
 	ioc.length = seg->size;
 	ioc.secinfo = (unsigned long)&secinfo;
-	ioc.flags = SGX_PAGE_MEASURE;
+	if (seg->measure)
+		ioc.flags = SGX_PAGE_MEASURE;
+	else
+		ioc.flags = 0;
 
 	rc = ioctl(encl->fd, SGX_IOC_ENCLAVE_ADD_PAGES, &ioc);
 	if (rc < 0) {
@@ -230,6 +233,7 @@ bool encl_load(const char *path, struct encl *encl)
 		seg->offset = (phdr->p_offset & PAGE_MASK) - src_offset;
 		seg->size = (phdr->p_filesz + PAGE_SIZE - 1) & PAGE_MASK;
 		seg->src = encl->src + seg->offset;
+		seg->measure = true;
 
 		j++;
 	}
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index 452d11d..aebc69e 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -12,6 +12,7 @@ struct encl_segment {
 	size_t size;
 	unsigned int prot;
 	unsigned int flags;
+	bool measure;
 };
 
 struct encl {
diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index 202a96f..50c5ab1 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -296,8 +296,10 @@ static bool mrenclave_segment(EVP_MD_CTX *ctx, struct encl *encl,
 		if (!mrenclave_eadd(ctx, seg->offset + offset, seg->flags))
 			return false;
 
-		if (!mrenclave_eextend(ctx, seg->offset + offset, seg->src + offset))
-			return false;
+		if (seg->measure) {
+			if (!mrenclave_eextend(ctx, seg->offset + offset, seg->src + offset))
+				return false;
+		}
 	}
 
 	return true;
