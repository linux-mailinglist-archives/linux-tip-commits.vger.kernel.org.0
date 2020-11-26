Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F502C53C5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Nov 2020 13:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgKZMOp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Nov 2020 07:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgKZMOp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Nov 2020 07:14:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BF0C0613D4;
        Thu, 26 Nov 2020 04:14:44 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:14:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606392883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxy39yWj5RVUiaFh1SEO1pqw1vyYRUxNHy3KF12oS/Q=;
        b=TTPm4DK1Gp1MooGgbIJtCzIPQ4j1IU9UoKDUJEE6OJfUXsRmlikP3qRkWfSJBCycXBfwfd
        XRX2/6ipbqeDKs2YC1ziMgXfF9P2N8JT8DGj6P2qx0iCus27frUCD7GLTODPYoHr0mvbmG
        3qxrWt5JJ9OHzVSn3mJXCwVdMqzKdIScqG/VMP3Dru99FE9R0uUigt8QDXzu3w3SZIKgDO
        Kyc2bZzwkV+7V6dQstm6Xrl7tahwCE0hedWkAi4DoHEZXwkj4MPOPsGBLouerISlN48Gv9
        i2Ln81PALRoaYy3Wdikj7IGq0LoWSSPLDlfKK9E8m66JfRdKerypr6HudqKJ+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606392883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxy39yWj5RVUiaFh1SEO1pqw1vyYRUxNHy3KF12oS/Q=;
        b=M63xevglf9+ZBRxYr3HKMA2nydFbU3v7My13ZILeE882w7iMMXUxvsjM1FcOjrqNW7NV8e
        4aczMPDVQbYnfhAA==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/asm: Drop unused RDPID macro
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201027214532.1792-1-sean.j.christopherson@intel.com>
References: <20201027214532.1792-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <160639288228.3364.6749574723160205981.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     8539d3f06710a9e91b9968fa736549d7c6b44206
Gitweb:        https://git.kernel.org/tip/8539d3f06710a9e91b9968fa736549d7c6b44206
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Tue, 27 Oct 2020 14:45:32 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 26 Nov 2020 12:58:56 +01:00

x86/asm: Drop unused RDPID macro

Drop the GAS-compatible RDPID macro. RDPID is unsafe in the kernel
because KVM loads guest's TSC_AUX on VM-entry and may not restore the
host's value until the CPU returns to userspace.

See

  6a3ea3e68b8a ("x86/entry/64: Do not use RDPID in paranoid entry to accomodate KVM")

for details.

It can always be resurrected from git history, if needed.

 [ bp: Massage commit message. ]

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201027214532.1792-1-sean.j.christopherson@intel.com
---
 arch/x86/include/asm/inst.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/x86/include/asm/inst.h b/arch/x86/include/asm/inst.h
index bd7f024..438ccd4 100644
--- a/arch/x86/include/asm/inst.h
+++ b/arch/x86/include/asm/inst.h
@@ -143,21 +143,6 @@
 	.macro MODRM mod opd1 opd2
 	.byte \mod | (\opd1 & 7) | ((\opd2 & 7) << 3)
 	.endm
-
-.macro RDPID opd
-	REG_TYPE rdpid_opd_type \opd
-	.if rdpid_opd_type == REG_TYPE_R64
-	R64_NUM rdpid_opd \opd
-	.else
-	R32_NUM rdpid_opd \opd
-	.endif
-	.byte 0xf3
-	.if rdpid_opd > 7
-	PFX_REX rdpid_opd 0
-	.endif
-	.byte 0x0f, 0xc7
-	MODRM 0xc0 rdpid_opd 0x7
-.endm
 #endif
 
 #endif
