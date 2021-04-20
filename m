Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACAC365475
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 10:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhDTIrI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 04:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhDTIrI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 04:47:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146AEC06174A;
        Tue, 20 Apr 2021 01:46:37 -0700 (PDT)
Date:   Tue, 20 Apr 2021 08:46:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618908393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WWM832S9BcrPc+QBzCiDbAukobV57lBiusLpUgarQ3o=;
        b=JXuQiluqXjcT/FGPmC94IfHzNegA/PFYd1O64UT2gCX1ko85LrS4LM0z9IiIT7PX9Qb81/
        XCoLmFyboqYlvDYx+iH0QXENv8igflDH9kMqHHXl8JWXnWKU7ql/8jMBG7bWLzxB782sPT
        /GEVgW1s6yRFChMiTudgpOLJJhm6Kod56lR5LgfG20F1wFebKqcoHbVro/8n56EYWuAepy
        9tYwgXm5GiDqy/Q2D8/Rdh4PZF5LPm1q7twpvFouf36QTnInNjKQU4EfJj8/yRBcAnRa3A
        4p75c903mYIKxNuz1h7kRkaFSzv4VcCnd5DHOyQs11uiYa3m7MCKzhJnABoGMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618908393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WWM832S9BcrPc+QBzCiDbAukobV57lBiusLpUgarQ3o=;
        b=7Hxt2EZRgfc3PSJ2S4vBvOtRA6Ccw1571IjGKLiwuA5nHYshOPrQfibQjmCUY4/3M6UHVJ
        VDgfzUqNw7oMqRCA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Fix !KEXEC build failure
Cc:     Ingo Molnar <mingo@kernel.org>, Mike Travis <travis@sgi.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <161890839241.29796.159814055731693380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     c2209ea55612efac75de0a58ef5f7394fae7fa0f
Gitweb:        https://git.kernel.org/tip/c2209ea55612efac75de0a58ef5f7394fae=
7fa0f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 20 Apr 2021 09:47:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 20 Apr 2021 10:08:23 +02:00

x86/platform/uv: Fix !KEXEC build failure

When KEXEC is disabled, the UV build fails:

  arch/x86/platform/uv/uv_nmi.c:875:14: error: =E2=80=98uv_nmi_kexec_failed=
=E2=80=99 undeclared (first use in this function)

Since uv_nmi_kexec_failed is only defined in the KEXEC_CORE #ifdef branch,
this code cannot ever have been build tested:

	if (main)
		pr_err("UV: NMI kdump: KEXEC not supported in this kernel\n");
	atomic_set(&uv_nmi_kexec_failed, 1);

Nor is this use possible in uv_handle_nmi():

                atomic_set(&uv_nmi_kexec_failed, 0);

These bugs were introduced in this commit:

    d0a9964e9873: ("x86/platform/uv: Implement simple dump failover if kdump =
fails")

Which added the uv_nmi_kexec_failed assignments to !KEXEC code, while making =
the
definition KEXEC-only - apparently without testing the !KEXEC case.

Instead of complicating the #ifdef maze, simplify the code by requiring X86_UV
to depend on KEXEC_CORE. This pattern is present in other architectures as we=
ll.

( We'll remove the untested, 7 years old !KEXEC complications from the file i=
n a
  separate commit. )

Fixes: d0a9964e9873: ("x86/platform/uv: Implement simple dump failover if kdu=
mp fails")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Mike Travis <travis@sgi.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879..d9776c9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -571,6 +571,7 @@ config X86_UV
 	depends on X86_EXTENDED_PLATFORM
 	depends on NUMA
 	depends on EFI
+	depends on KEXEC_CORE
 	depends on X86_X2APIC
 	depends on PCI
 	help
