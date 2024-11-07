Return-Path: <linux-tip-commits+bounces-2815-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 469A79BFC24
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 03:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CADA31F21353
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AA51946AA;
	Thu,  7 Nov 2024 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NWqM7LNp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SEfYK6x7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22291922F3;
	Thu,  7 Nov 2024 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944787; cv=none; b=a09P42TitrCtt1riD4U5Z98ZJa3RZrt+X3QimJ+iHlUMIAvg5stvHI52h909J6N/OfKq7ppG0FyG7mq8o+bXhbjpU8FKAngGFYZ61YccRidWmuWta39PsU3DmJt1akx9lmDUOARp1juypKivV+RFUdBeIjJp+1qOOuKobXl+lDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944787; c=relaxed/simple;
	bh=VMSyGInWCe2uET3fOrApNyxq+ywHhgO5dRhoHiJQgIs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PKS4rYoyIFJQn0AMxclxTQ3SRRiazsVpLjhDhbr+KMlG4J4QaEiswU52HOdMTY5fSLU6mw9SLKEqwsUVtRlnyADGLnt98rSPija1xmsjub0OFDTgKzSiWa4pOOvftFK5NZMo5ZUmdhz3j88UBzWlrBoEeaWlCpQYDys5uoVwTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NWqM7LNp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SEfYK6x7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944784;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skyT+nJT4XQznxXW0lzsMAVpvRPFqeNQo1O8/mPLCwc=;
	b=NWqM7LNpZXth7t6yzJNZ4LroRzw+RakEBpzJKBp5YzSHRs2u5pT2ZYFriZbQsMskWlszQh
	bPrz8YzhKHRnFUO1vNtPsuYPBxySWxFZS5+q/y5oQUul42tHkrDLsz6Jc8i/MzX+GB+AuR
	CTrh8HIJyZvTQy8gjhTN05uVjPObudYM5TeG+6AgOrh53GWrWtnMJX0n7xhuVVZKKgewF/
	Qy/bkQ3Tb9Rr+3Jl46pPGf9NLDanXaS0hkPYW1fZ21yMfSLw/rRj4supFt0k1F1aDsaBb9
	BbMQTnf8MvnhZ5TxWsZSpa00h8e2JfDYAFZtdW1tQH6IR7CuF5C7xDehvfNshw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944784;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skyT+nJT4XQznxXW0lzsMAVpvRPFqeNQo1O8/mPLCwc=;
	b=SEfYK6x7ElLAnSvh4LiUxmwC6tXXQNi13QT+wrFez7cyWxeggCzCpy/ZVO4I/eQMC+XpDR
	aU8uk1DVTlQQw7AA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimers: Introduce hrtimer_setup_on_stack()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4b05e2ab3a82c517adf67fabc0f0cd8fe118b97c=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C4b05e2ab3a82c517adf67fabc0f0cd8fe118b97c=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094478329.32228.14019232019945761019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     444cb7db4c9f9b5d96be17c38b3e989df7bfabd5
Gitweb:        https://git.kernel.org/tip/444cb7db4c9f9b5d96be17c38b3e989df7bfabd5
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:05 +01:00

hrtimers: Introduce hrtimer_setup_on_stack()

To initialize hrtimer on stack, hrtimer_init_on_stack() needs to be called
and also hrtimer::function must be set. This is error-prone and awkward to
use.

Introduce hrtimer_setup_on_stack() which does both of these things, so that
users of hrtimer can be simplified.

The new setup function also has a sanity check for the provided function
pointer. If NULL, a warning is emitted and a dummy callback installed.

hrtimer_init_on_stack() will be removed as soon as all of its users have
been converted to the new function.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/4b05e2ab3a82c517adf67fabc0f0cd8fe118b97c.1730386209.git.namcao@linutronix.de

---
 include/linux/hrtimer.h |  3 +++
 kernel/time/hrtimer.c   | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index bcc0715..2da513f 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -232,6 +232,9 @@ extern void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*function
 			  clockid_t clock_id, enum hrtimer_mode mode);
 extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_clock,
 				  enum hrtimer_mode mode);
+extern void hrtimer_setup_on_stack(struct hrtimer *timer,
+				   enum hrtimer_restart (*function)(struct hrtimer *),
+				   clockid_t clock_id, enum hrtimer_mode mode);
 extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
 					  clockid_t clock_id,
 					  enum hrtimer_mode mode);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index a5ef67e..daee4e2 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1646,6 +1646,25 @@ void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t clock_id,
 }
 EXPORT_SYMBOL_GPL(hrtimer_init_on_stack);
 
+/**
+ * hrtimer_setup_on_stack - initialize a timer on stack memory
+ * @timer:	The timer to be initialized
+ * @function:	the callback function
+ * @clock_id:	The clock to be used
+ * @mode:       The timer mode
+ *
+ * Similar to hrtimer_setup(), except that this one must be used if struct hrtimer is in stack
+ * memory.
+ */
+void hrtimer_setup_on_stack(struct hrtimer *timer,
+			    enum hrtimer_restart (*function)(struct hrtimer *),
+			    clockid_t clock_id, enum hrtimer_mode mode)
+{
+	debug_init_on_stack(timer, clock_id, mode);
+	__hrtimer_setup(timer, function, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_setup_on_stack);
+
 /*
  * A timer is active, when it is enqueued into the rbtree or the
  * callback function is running or it's in the state of being migrated

