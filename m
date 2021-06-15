Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0CF3A7C72
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Jun 2021 12:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhFOKyG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Jun 2021 06:54:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60994 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhFOKyD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Jun 2021 06:54:03 -0400
Date:   Tue, 15 Jun 2021 10:51:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623754317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BN2j1wmbKj7b6p7QuC2us0J+U+T41P2QrF5xy1G54Zs=;
        b=b/7tecHsGKS5/NbDF4DG/bhCPDrS7rCxmGNJdpn9MmjEOHjdvBxVL1RAoExVrCYaqFztMd
        yQXDbG1uH5PaIR0KWRc05t/LG+Yi4vpi6e/2gs/IXuoYAr9oQWrUUSx5cS4Lac61rh9X0R
        7BWbvnLs47N0a9beEYmC7P7Xdtr3XJj5YwDsrEcIXVWBddc8w7MenmR9Ypnn7Dj0bsNml6
        8x9ELY4C0bs2BqPYbUpCDmzza74JYD6Pn5/Ox7IfKZrg2UHnT1Bu0hrZnRnPI3DH8qo360
        3eD2OO4cQrJTrfoGTE9kvuol0NC0Hcn1YBEX6fiGmkds4Nh7J4tlqyuFFQrUjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623754317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BN2j1wmbKj7b6p7QuC2us0J+U+T41P2QrF5xy1G54Zs=;
        b=FgoErSThf3L1bkMPRIfPyE2qWQqhDiQthbfju/nuN855exI0LCnI3dsTsBlYGk6cUlPGik
        ppqIqOiRjO8bDUAg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/insn-eval: Make 0 a valid RIP for insn_get_effective_ip()
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210614135327.9921-5-joro@8bytes.org>
References: <20210614135327.9921-5-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <162375431710.19906.15502392185639709333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     f2df15639e44d23bf82a86a03092472c7278cd39
Gitweb:        https://git.kernel.org/tip/f2df15639e44d23bf82a86a03092472c7278cd39
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Wed, 19 May 2021 15:52:49 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Jun 2021 11:24:21 +02:00

x86/insn-eval: Make 0 a valid RIP for insn_get_effective_ip()

In theory, 0 is a valid value for the instruction pointer so don't use
it as the error return value from insn_get_effective_ip().

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210614135327.9921-5-joro@8bytes.org
---
 arch/x86/lib/insn-eval.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index a67afd7..4eecb9c 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1417,7 +1417,7 @@ void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs)
 	}
 }
 
-static unsigned long insn_get_effective_ip(struct pt_regs *regs)
+static int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip)
 {
 	unsigned long seg_base = 0;
 
@@ -1430,10 +1430,12 @@ static unsigned long insn_get_effective_ip(struct pt_regs *regs)
 	if (!user_64bit_mode(regs)) {
 		seg_base = insn_get_seg_base(regs, INAT_SEG_REG_CS);
 		if (seg_base == -1L)
-			return 0;
+			return -EINVAL;
 	}
 
-	return seg_base + regs->ip;
+	*ip = seg_base + regs->ip;
+
+	return 0;
 }
 
 /**
@@ -1455,8 +1457,7 @@ int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
 	unsigned long ip;
 	int not_copied;
 
-	ip = insn_get_effective_ip(regs);
-	if (!ip)
+	if (insn_get_effective_ip(regs, &ip))
 		return 0;
 
 	not_copied = copy_from_user(buf, (void __user *)ip, MAX_INSN_SIZE);
@@ -1484,8 +1485,7 @@ int insn_fetch_from_user_inatomic(struct pt_regs *regs, unsigned char buf[MAX_IN
 	unsigned long ip;
 	int not_copied;
 
-	ip = insn_get_effective_ip(regs);
-	if (!ip)
+	if (insn_get_effective_ip(regs, &ip))
 		return 0;
 
 	not_copied = __copy_from_user_inatomic(buf, (void __user *)ip, MAX_INSN_SIZE);
