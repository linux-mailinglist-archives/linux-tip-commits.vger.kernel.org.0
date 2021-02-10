Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466E2316D38
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 18:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhBJRsI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 12:48:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33180 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbhBJRra (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 12:47:30 -0500
Date:   Wed, 10 Feb 2021 17:45:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612979156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7yTzTkVoRvGtzSglQp9zfhnq4wMKOSaMfmohzQrwOs=;
        b=uJmryKqugcJNvgP/wLBYRA8YA/wn2kDgvq4zNcy0rYEbWqFManzXNrtDmTv/ovaq3yqmmQ
        bglY23XFBjdFKw39qicdyCHt0/bxSFXeVpu0f3VaBFu8z50jxz+0W9t7MbAVtx5T8YR16f
        k/PvPuYbrrBSsalqMGylJ/7w88bU5G6i9jozaT6qOkYqEWyMvoDhU37m31oBoFP1vGqcY7
        M5LO92W1LZQ2bW9U58SH3gYF0g+WbOHByFZAhaZN1K7VskSkiwAm3r2/4QVdtA7jodCqxu
        asRk/tqaTP0KzG8nvFeE6LrQx0m26PsaW61Yu44MnfatYj7OS7uxJp9CKbWAKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612979156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7yTzTkVoRvGtzSglQp9zfhnq4wMKOSaMfmohzQrwOs=;
        b=x4mruRg0YeinwLa5o+ESclzAVJfxLyTH9my6jVNYuy8hozqiA2O6aEhD1UgoloG6/6F1WL
        MpEe8lfJwM2IroCg==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/fault: Document the locking in the
 fault_signal_pending() path
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <c56de3d103f40e6304437b150aa7b215530d23f7.1612924255.git.luto@kernel.org>
References: <c56de3d103f40e6304437b150aa7b215530d23f7.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161297915599.23325.15354587585841772499.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     ef2544fb3f6457b79fc73cea39dafd67ee0f2824
Gitweb:        https://git.kernel.org/tip/ef2544fb3f6457b79fc73cea39dafd67ee0f2824
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 09 Feb 2021 18:33:37 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Feb 2021 14:12:07 +01:00

x86/fault: Document the locking in the fault_signal_pending() path

If fault_signal_pending() returns true, then the core mm has unlocked the
mm for us.  Add a comment to help future readers of this code.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/c56de3d103f40e6304437b150aa7b215530d23f7.1612924255.git.luto@kernel.org
---
 arch/x86/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 3ffed00..013910b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1380,8 +1380,11 @@ good_area:
 	 */
 	fault = handle_mm_fault(vma, address, flags, regs);
 
-	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
+		/*
+		 * Quick path to respond to signals.  The core mm code
+		 * has unlocked the mm for us if we get here.
+		 */
 		if (!user_mode(regs))
 			no_context(regs, error_code, address, SIGBUS,
 				   BUS_ADRERR);
