Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA52316D29
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 18:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbhBJRqx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 12:46:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33126 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbhBJRqo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 12:46:44 -0500
Date:   Wed, 10 Feb 2021 17:45:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612979155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQaPtQ+1e8VOx3J+mBKPQoFu1nZyfmAc/5U1bU1maPs=;
        b=NO1Q61+HVg9ZMI409pvYzzxMUHZdogItsSULJlBCB5/3+0Ybfao1Q884dacBHVHFdecMti
        xExAi73cxm1PcklhNL3mTr6TT0uTBKcmI5mN5fBMzpv6fbLT3/JkjQQ4rXggfpOMf4GwDp
        IVytgWOUM3C6jifzguWEhUIn4rAZduTqzSb3fiaS5T6kQwTyBL82fJfUBfgkCcOwZIMeDB
        zd/ivBFKLsI8Zde3Xc/WvLDsGQnDUjviAT+PSMHWpJgOExirWYSpchPv2KlBq01nG3bEqt
        rQTGcrDIyYqKqqHJ5SQSbPBNb7FOd3nvAfpvrxGsMX3JMYkAxbhhCHDozSCM4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612979155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQaPtQ+1e8VOx3J+mBKPQoFu1nZyfmAc/5U1bU1maPs=;
        b=NE1v5+gIBsJLqZt+aHASb+h0P5jIoceVc19BKAk61FieYFb8+MZ0zcB6YExZGNhan6FwBe
        z+XPWzZpiWiJG7DA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/fault: Don't look for extable entries for SMEP violations
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <46160d8babce2abf1d6daa052146002efa24ac56.1612924255.git.luto@kernel.org>
References: <46160d8babce2abf1d6daa052146002efa24ac56.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161297915473.23325.10829344370520617667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     66fcd98883816dba3b66da20b5fc86fa410638b5
Gitweb:        https://git.kernel.org/tip/66fcd98883816dba3b66da20b5fc86fa410638b5
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 09 Feb 2021 18:33:44 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Feb 2021 14:45:39 +01:00

x86/fault: Don't look for extable entries for SMEP violations

If the kernel gets a SMEP violation or a fault that would have been a
SMEP violation if it had SMEP support, it shouldn't run fixups. Just
OOPS.

 [ bp: Massage commit message. ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/46160d8babce2abf1d6daa052146002efa24ac56.1612924255.git.luto@kernel.org
---
 arch/x86/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 3566a59..1a0cfed 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1250,12 +1250,12 @@ void do_user_addr_fault(struct pt_regs *regs,
 		 * user memory.  Unless this is AMD erratum #93, which
 		 * corrupts RIP such that it looks like a user address,
 		 * this is unrecoverable.  Don't even try to look up the
-		 * VMA.
+		 * VMA or look for extable entries.
 		 */
 		if (is_errata93(regs, address))
 			return;
 
-		bad_area_nosemaphore(regs, error_code, address);
+		page_fault_oops(regs, error_code, address);
 		return;
 	}
 
