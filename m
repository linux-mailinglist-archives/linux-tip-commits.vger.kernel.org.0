Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0E12A3415
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Nov 2020 20:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgKBTcY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 2 Nov 2020 14:32:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60792 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBTcY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 2 Nov 2020 14:32:24 -0500
Date:   Mon, 02 Nov 2020 19:32:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604345541;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z4uyfQQR6uE0SLbR8+UC/I0FpBvhtKFDSZ+2WlK89r8=;
        b=EBZMkFK+b/DSDKCbK5fGx7Aiq+gpLRWY078rbY8fvfNv6Ez4F0lKtK5dGV7Wvl4G5kGPGE
        xMW07fhYRsvU7EGVfyyTFp36vZzTerzj9AyXe/Mw43Ru/qZLAlbPHVb2BeEHkXCSP3V7OU
        fbxdOwJLEXTudfS70pGzDP7xV0N+ct6+k3Xi4wLdIWFs9NhPZmO+8ugwX0WQFGwvKzq8fd
        N95S5vHBmy2Hw2ssyjcXpNyoUfkjSDaGHTzDBL8m91HY/UDSBM5BD8wU3+tSgGNYZqkF8m
        PbeMejME/hRmZXkmLbqUCsccGIVG8NBnf/5kR4tEboQFL9KHFjI58jLKCoBzmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604345541;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z4uyfQQR6uE0SLbR8+UC/I0FpBvhtKFDSZ+2WlK89r8=;
        b=9SbUJ7f2sSEinzHWHCDZ4SUH986xnNHDQY4OLMvBjmgG35SUPHYDl7dfwkIlz8YqodKlBa
        z2eZlz17w/mpDwAA==
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mtrr: Fix a kernel-doc markup
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C2217cd4ae9e561da2825485eb97de77c65741489=2E16034?=
 =?utf-8?q?69755=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3C2217cd4ae9e561da2825485eb97de77c65741489=2E160346?=
 =?utf-8?q?9755=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <160434554031.397.3549896302579770108.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     4a2d2ed9bae16c14602e7aebba3f0c90f73fe786
Gitweb:        https://git.kernel.org/tip/4a2d2ed9bae16c14602e7aebba3f0c90f73fe786
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Fri, 23 Oct 2020 18:32:53 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 02 Nov 2020 19:58:53 +01:00

x86/mtrr: Fix a kernel-doc markup

Kernel-doc markup should use this format:
	identifier - description

Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/2217cd4ae9e561da2825485eb97de77c65741489.1603469755.git.mchehab+huawei@kernel.org
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 6a80f36..08a30c8 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -813,7 +813,8 @@ void mtrr_ap_init(void)
 }
 
 /**
- * Save current fixed-range MTRR state of the first cpu in cpu_online_mask.
+ * mtrr_save_state - Save current fixed-range MTRR state of the first
+ *	cpu in cpu_online_mask.
  */
 void mtrr_save_state(void)
 {
