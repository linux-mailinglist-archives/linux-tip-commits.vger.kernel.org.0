Return-Path: <linux-tip-commits+bounces-3658-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22985A45D36
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 207517A103C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0456519CD16;
	Wed, 26 Feb 2025 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mwoyUqjX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VoWPTwdu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B05F322A;
	Wed, 26 Feb 2025 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569570; cv=none; b=sTvUaUQdZ0LXdzpOPfinY+sSdRxiEYDlLmOFvA4Ia6+g1nTf8JTi4D9R8a+TcD6Jv9rFblY1RGkqhik8giSJuVhqKwJ3QPE7cNl7U03Yfv6fGOXWSwTWZlgOzvnj0J+zMWXUVPNiclVhSyQTNdowMPgOWyEiyReBEOHhPpjAP1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569570; c=relaxed/simple;
	bh=dQLj8MZf4R+QW6c2o5Xfyy6VuVALN8KafNc4OHy49p8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=osxSFNFPA/Y0SII0Vrr1lLlwQ4InZLPkTKG59zUhBOCmFrMcTjPD/jbKpZWyAxVRdzfjJJa5ML9iiFoOhTqZdbqb6oiSuy8r+v9I4qplYC/3TW6KIqQ2qcAwhfRN8mhW6He3VrqNaPejkw0tRFTvBOs7qC7ftAotxj9m1aFfKkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mwoyUqjX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VoWPTwdu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 11:32:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740569567;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEMNPcMmxhiqSJW4zJbGtQeGjB58PtznAAcjriCRABU=;
	b=mwoyUqjXOicRWnIn3+CCYtaQfweGLBxdn0iJxBaKliO+PMvlszo3MG3C6NlWvq+ZWZSRpt
	Xzfb5Cg0PPgmYzJzudzPYucnPzezBXVQtMKedhpZcHfN1/Melo93YALlFccIbHfyOasNZu
	udD9q8tJ4gigspqopCBXkRjDN+nxDebQRRrj16S5ca01adev4rSCqvx+tG6wgkko2yzDnt
	GG9wSBw4esn86/29rsXZ8kmEvAa/oJSMNBFePTmIwRGOJf33os29v1+YNMu0zk07javZud
	QlFD5unsJ8PtfBn2Ju55o7hQ/WCA8GHlXCitw5nX4sT+8/yVGz5tvLdAX2Y3VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740569567;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEMNPcMmxhiqSJW4zJbGtQeGjB58PtznAAcjriCRABU=;
	b=VoWPTwdupsGx7a9yu8gIe1mz6BmiZuN+nUjuiRMazOGEqAaNt1Kgr3T6oLwW0HnVyKLtet
	kTMw0R5nMfQL8hDw==
From: "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/inject: Remove call to mce_notify_irq()
Cc: Nikolay Borisov <nik.borisov@suse.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250225143348.268469-1-nik.borisov@suse.com>
References: <20250225143348.268469-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056956644.10177.4335418535557398058.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     6447828875b7d768e4ef0f58765b4bd4e16bcf18
Gitweb:        https://git.kernel.org/tip/6447828875b7d768e4ef0f58765b4bd4e16bcf18
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Tue, 25 Feb 2025 16:33:48 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 26 Feb 2025 12:18:37 +01:00

x86/mce/inject: Remove call to mce_notify_irq()

The call to mce_notify_irq() has been there since the initial version of
the soft inject mce machinery, introduced in

  ea149b36c7f5 ("x86, mce: add basic error injection infrastructure").

At that time it was functional since injecting an MCE resulted in the
following call chain:

  raise_mce()
    ->machine_check_poll()
        ->mce_log() - sets notfiy_user_bit
  ->mce_notify_user() (current mce_notify_irq) consumed the bit and called the
  usermode helper.

However, with the introduction of

  011d82611172 ("RAS: Add a Corrected Errors Collector")

the code got moved around and the usermode helper began to be called via the
early notifier mce_first_notifier() rendering the call in raise_local()
defunct as the mce_need_notify bit (ex notify_user) is only being set from the
early notifier.

Remove the noop call and make mce_notify_irq() static.

No functional changes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250225143348.268469-1-nik.borisov@suse.com
---
 arch/x86/include/asm/mce.h       |  2 +-
 arch/x86/kernel/cpu/mce/core.c   | 44 +++++++++++++++----------------
 arch/x86/kernel/cpu/mce/inject.c |  1 +-
 3 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index eb2db07..6c77c03 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -296,8 +296,6 @@ enum mcp_flags {
 
 void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
 
-bool mce_notify_irq(void);
-
 DECLARE_PER_CPU(struct mce, injectm);
 
 /* Disable CMCI/polling for MCA bank claimed by firmware */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0dc00c9..1f14c33 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -584,6 +584,28 @@ bool mce_is_correctable(struct mce *m)
 }
 EXPORT_SYMBOL_GPL(mce_is_correctable);
 
+/*
+ * Notify the user(s) about new machine check events.
+ * Can be called from interrupt context, but not from machine check/NMI
+ * context.
+ */
+static bool mce_notify_irq(void)
+{
+	/* Not more than two messages every minute */
+	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
+
+	if (test_and_clear_bit(0, &mce_need_notify)) {
+		mce_work_trigger();
+
+		if (__ratelimit(&ratelimit))
+			pr_info(HW_ERR "Machine check events logged\n");
+
+		return true;
+	}
+
+	return false;
+}
+
 static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
@@ -1773,28 +1795,6 @@ static void mce_timer_delete_all(void)
 		del_timer_sync(&per_cpu(mce_timer, cpu));
 }
 
-/*
- * Notify the user(s) about new machine check events.
- * Can be called from interrupt context, but not from machine check/NMI
- * context.
- */
-bool mce_notify_irq(void)
-{
-	/* Not more than two messages every minute */
-	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
-
-	if (test_and_clear_bit(0, &mce_need_notify)) {
-		mce_work_trigger();
-
-		if (__ratelimit(&ratelimit))
-			pr_info(HW_ERR "Machine check events logged\n");
-
-		return true;
-	}
-	return false;
-}
-EXPORT_SYMBOL_GPL(mce_notify_irq);
-
 static void __mcheck_cpu_mce_banks_init(void)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 313fe68..06e3cf7 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -229,7 +229,6 @@ static int raise_local(void)
 	} else if (m->status) {
 		pr_info("Starting machine check poll CPU %d\n", cpu);
 		raise_poll(m);
-		mce_notify_irq();
 		pr_info("Machine check poll done on CPU %d\n", cpu);
 	} else
 		m->finished = 0;

