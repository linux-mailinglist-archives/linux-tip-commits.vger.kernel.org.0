Return-Path: <linux-tip-commits+bounces-2262-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0101C9720E9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883D0286318
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9250718E053;
	Mon,  9 Sep 2024 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GUMnw+a6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ap+YMQxb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A118C924;
	Mon,  9 Sep 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902882; cv=none; b=BVyQcISSuuQiI4trgN3Eo0QnkqMiAjZzPvZRyj4UjjK4eCUl4GOyJ7fto4d0wLPc5WfiA7W5B3hqz/U/RiLJdRwPBJxtmkBrYTnVJOrk//4Mv1Sm05aeQP+kDafRVJ5Q830lTywZyDgpIj16iDu2DI/yUolE6u3cju3W4FA04lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902882; c=relaxed/simple;
	bh=6itz2Q1yZyuu14r+8Ea4PlUMEHK9T4GTxDm0i7GmkEg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Hb9Vj7aV01ifZ3ADxaHp9vo7oQiwdA1wPKLapivfeJpiWHPIe1cin0CJaUgbsf9WoFaSNr3F7ofn2b7Mumm62BSeX+0+LfadAPAN1dvvzm8NZmtvyj3rZCLTEdgazEVNl9UlfB7dPFe2vf3peW6zBSeS3tFWhhzVmpuqpIs7w1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GUMnw+a6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ap+YMQxb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WT+xNMSACFJmt4NFfSOUVk6vU7YVXi99Om+t8kyz0L0=;
	b=GUMnw+a64StbJtQTP6LKXM85ywwPv7Z1dP/C32zNvS3COzudwOj97aj6WoBIwsfUJz5mjs
	dUwTKzTH6U2Z2KOgxdAeMlFjsOfi3sFKr2dSb9FbKBGxS/a/P4BAF2HlSt9yiNRUbuReIB
	Bu5UuCOhdSbNB1NUxXKnurB8USNQahBoCaCwuKrX9/f6YWsAGdOEQ2vYZ+IrGmUZJxPKLr
	R5fxoe/9ROkSxb8NHLmqnvA/m7j3yEEr6OLptmHnxQ4S3eRfCHzWz9SyiJgQfr4qWIY2LJ
	/D3MfwfquPpWeDuoiht8KbJOrlc5x+qtH13iraixT5wQrGSVkMELKKaz/c08Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WT+xNMSACFJmt4NFfSOUVk6vU7YVXi99Om+t8kyz0L0=;
	b=ap+YMQxb5QyI0FhX8dSO9VIiThR42608N/pPGjnKZqBXVhU8gyK6t6oUfWwS7EFftVa4/g
	B3lSc1FEFzFVLiCQ==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/rt] printk: nbcon: Add callbacks to synchronize with driver
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-9-john.ogness@linutronix.de>
References: <20240820063001.36405-9-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287773.2215.7710379488456199238.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     7a16a771890746b4060333d665ebe674945a3cfa
Gitweb:        https://git.kernel.org/tip/7a16a771890746b4060333d665ebe674945a3cfa
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:34 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:23 +02:00

printk: nbcon: Add callbacks to synchronize with driver

Console drivers typically must deal with access to the hardware
via user input/output (such as an interactive login shell) and
output of kernel messages via printk() calls. To provide the
necessary synchronization, usually some driver-specific locking
mechanism is used (for example, the port spinlock for uart
serial consoles).

Until now, usage of this driver-specific locking has been hidden
from the printk-subsystem and implemented within the various
console callbacks. However, nbcon consoles would need to use it
even in the generic code.

Add device_lock() and device_unlock() callback which will need
to get implemented by nbcon consoles.

The callbacks will use whatever synchronization mechanism the
driver is using for itself. The minimum requirement is to
prevent CPU migration. It would allow a context friendly
acquiring of nbcon console ownership in non-emergency and
non-panic context.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-9-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h | 43 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 35c64ee..46b3c21 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -372,6 +372,49 @@ struct console {
 	 */
 	void (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
 
+	/**
+	 * @device_lock:
+	 *
+	 * NBCON callback to begin synchronization with driver code.
+	 *
+	 * Console drivers typically must deal with access to the hardware
+	 * via user input/output (such as an interactive login shell) and
+	 * output of kernel messages via printk() calls. This callback is
+	 * called by the printk-subsystem whenever it needs to synchronize
+	 * with hardware access by the driver. It should be implemented to
+	 * use whatever synchronization mechanism the driver is using for
+	 * itself (for example, the port lock for uart serial consoles).
+	 *
+	 * The callback is always called from task context. It may use any
+	 * synchronization method required by the driver.
+	 *
+	 * IMPORTANT: The callback MUST disable migration. The console driver
+	 *	may be using a synchronization mechanism that already takes
+	 *	care of this (such as spinlocks). Otherwise this function must
+	 *	explicitly call migrate_disable().
+	 *
+	 * The flags argument is provided as a convenience to the driver. It
+	 * will be passed again to device_unlock(). It can be ignored if the
+	 * driver does not need it.
+	 */
+	void (*device_lock)(struct console *con, unsigned long *flags);
+
+	/**
+	 * @device_unlock:
+	 *
+	 * NBCON callback to finish synchronization with driver code.
+	 *
+	 * It is the counterpart to device_lock().
+	 *
+	 * This callback is always called from task context. It must
+	 * appropriately re-enable migration (depending on how device_lock()
+	 * disabled migration).
+	 *
+	 * The flags argument is the value of the same variable that was
+	 * passed to device_lock().
+	 */
+	void (*device_unlock)(struct console *con, unsigned long flags);
+
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;

