Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4110640B7DC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhINTU7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:20:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbhINTUz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:55 -0400
Date:   Tue, 14 Sep 2021 19:19:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647176;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ypt2gI6IUxEp9UCE5TxsKMM15nvoYTtMM2+FxzD886E=;
        b=CasDu5BiR+3jXpSfKK6tE5phHXHSoNoZpMVhsoaSSbgpKXzUshmh1sKmsRvO44Gacomc4T
        eoYGtaF3R0MTALAKSzNQ3XxmZ1s1oU4OkVSD0VyHwWyuKxWEMUwaLHzpzqnU3JETGitO2l
        4fOm8wnAu2WdDo3zijZd30Z2OzOqK5GrEp89U/db/bYTn5l5MVwfjYQYt57XksyEG++ZB6
        cp9ry1+Ow+a35QbPT3yB0kj0CPPuEpoMnCbGJl560/3/n3WPsiFtRAB7xs9YoN8oTci+Mg
        Ui/76n8+gU5OhNXtbU097LEs83dMagoYrbn1e2Q2oQAK0yCfdjstSsrih2dzug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647176;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ypt2gI6IUxEp9UCE5TxsKMM15nvoYTtMM2+FxzD886E=;
        b=5tuoKJgh+ohQ2UE9T6z8eUNn8YhmskAfYVOn7EJ0RptOJ86YzC5MZFbGee35rk0ULX9bTz
        nLrTNT78COlPgQDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/mce: Get rid of stray semicolons
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210908132525.154428878@linutronix.de>
References: <20210908132525.154428878@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164717557.25758.15179321944702732919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     083b32d6f4fa26abaf585721abeee73c92ea5376
Gitweb:        https://git.kernel.org/tip/083b32d6f4fa26abaf585721abeee73c92ea5376
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:16 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Sep 2021 17:42:51 +02:00

x86/mce: Get rid of stray semicolons

and the random number of tabs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132525.154428878@linutronix.de
---
 arch/x86/kernel/cpu/mce/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 88dcc79..9509922 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -61,7 +61,7 @@ static inline void cmci_disable_bank(int bank) { }
 static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
 static inline void intel_clear_lmce(void) { }
-static inline bool intel_filter_mce(struct mce *m) { return false; };
+static inline bool intel_filter_mce(struct mce *m) { return false; }
 #endif
 
 void mce_timer_kick(unsigned long interval);
@@ -183,7 +183,7 @@ extern bool filter_mce(struct mce *m);
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
 #else
-static inline bool amd_filter_mce(struct mce *m)			{ return false; };
+static inline bool amd_filter_mce(struct mce *m) { return false; }
 #endif
 
 __visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
