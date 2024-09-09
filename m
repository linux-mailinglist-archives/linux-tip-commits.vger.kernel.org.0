Return-Path: <linux-tip-commits+bounces-2266-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CF09720F1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDE22855C9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC7F18E76C;
	Mon,  9 Sep 2024 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kFnoSNdW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nS2B99ij"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AAB18C903;
	Mon,  9 Sep 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902883; cv=none; b=mXCO8vFSZAiN6kxcXvHjWG4mseWDEmJKl8UoOACH8jqn1704x4rUVZu4qlgZewp9JaBKwQF/mOnZHNtn4yJUaog8yOiRSSjd27gaTCp+wD4evZZwzS7XJWAPrEjHZ2/QQO2BqeIIuRBbs7qJaSgQASNzQWohqtSMkbdzCEDGlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902883; c=relaxed/simple;
	bh=MuED1RBkG/FNLxUIpKlhLvPd6MzP95GCYSnTSM/odFY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NPjuRtFb0UBSYRPzSq/eOQ0YcHMeJqo238xQGNM6pthe56mYJJ5PWSwxg7W77i/Ebf7npb+g43X2VzpIeZmrdXvCX2A0vi5qWA5aXRpBBVY3y1eH7aa81ZxB+QHHQcRqh4PTevo+mxJS4HijUTZhzkhZ7bwHqEZvXByXPunWE/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kFnoSNdW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nS2B99ij; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902877;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeiLqdph7vwKbqeZFyPOdBzaqNFQtvo0FTF2SXh+TQk=;
	b=kFnoSNdWOxTPFofNybXIHAtmvzW6jfloEVFJMUcH9IBY5BDICdHFmeDEyHoV2aRlVHms3m
	8S9dp6ydRZ0cYMseUJb4+W6vn9/atyXWQ69rAnSOZpailXrLUtCiKW/l4+8Lm/ytpdrE+K
	13LmZRPAAxAk4h+JE7E8/gw2rxllFCcuivQQ1l8XHDyINuUbDBVaKqbiKg71pFc2QVTPeA
	Euit3WuWi5npkeIEnycmROowkWfl3qnHIwFAe15J6kzoQeGdDqy9w8mwkRRFrJrX9yZOrP
	73GT9z4w4c6bEl+H176mV+sQMj3C9QaUziBvGwAmgFxkjY6TBmpIsWpS3N2/cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902877;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeiLqdph7vwKbqeZFyPOdBzaqNFQtvo0FTF2SXh+TQk=;
	b=nS2B99ijHPdJTyR5jhJbSiOTo7PYU1rcnYbQTWPDRN0gtS5CUwLlyTCSHSwjF6UxIOh1Ng
	6uZcneECYRgDRPCg==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: nbcon: Use driver synchronization while
 (un)registering
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-10-john.ogness@linutronix.de>
References: <20240820063001.36405-10-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287740.2215.13042263784032670438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     e55c3bcf380c7593d768f31994eff63935081d06
Gitweb:        https://git.kernel.org/tip/e55c3bcf380c7593d768f31994eff63935081d06
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:35 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:23 +02:00

printk: nbcon: Use driver synchronization while (un)registering

Console drivers typically have to deal with access to the
hardware via user input/output (such as an interactive login
shell) and output of kernel messages via printk() calls.

They use some classic driver-specific locking mechanism in most
situations. But console->write_atomic() callbacks, used by nbcon
consoles, are synchronized only by acquiring the console
context.

The synchronization via the console context ownership is possible
only when the console driver is registered. It is when a
particular device driver is connected with a particular console
driver.

The two synchronization mechanisms must be synchronized between
each other. It is tricky because the console context ownership
is quite special. It might be taken over by a higher priority
context. Also CPU migration must be disabled. The most tricky
part is to (dis)connect these two mechanisms during the console
(un)registration.

Use the driver-specific locking callbacks: device_lock(),
device_unlock(). They allow taking the device-specific lock
while the device is being (un)registered by the related console
driver.

For example, these callbacks lock/unlock the port lock for
serial port drivers.

Note that the driver-specific locking is only needed during
(un)register if it is an nbcon console with the write_atomic()
callback implemented. If write_atomic() is not implemented, the
driver should never attempt to access the hardware without
first acquiring its driver-specific lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-10-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 20c3950..4cd2c50 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3548,9 +3548,11 @@ static int unregister_console_locked(struct console *console);
  */
 void register_console(struct console *newcon)
 {
-	struct console *con;
+	bool use_device_lock = (newcon->flags & CON_NBCON) && newcon->write_atomic;
 	bool bootcon_registered = false;
 	bool realcon_registered = false;
+	struct console *con;
+	unsigned long flags;
 	u64 init_seq;
 	int err;
 
@@ -3638,6 +3640,19 @@ void register_console(struct console *newcon)
 	}
 
 	/*
+	 * If another context is actively using the hardware of this new
+	 * console, it will not be aware of the nbcon synchronization. This
+	 * is a risk that two contexts could access the hardware
+	 * simultaneously if this new console is used for atomic printing
+	 * and the other context is still using the hardware.
+	 *
+	 * Use the driver synchronization to ensure that the hardware is not
+	 * in use while this new console transitions to being registered.
+	 */
+	if (use_device_lock)
+		newcon->device_lock(newcon, &flags);
+
+	/*
 	 * Put this console in the list - keep the
 	 * preferred driver at the head of the list.
 	 */
@@ -3661,6 +3676,10 @@ void register_console(struct console *newcon)
 	 * register_console() completes.
 	 */
 
+	/* This new console is now registered. */
+	if (use_device_lock)
+		newcon->device_unlock(newcon, flags);
+
 	console_sysfs_notify();
 
 	/*
@@ -3689,6 +3708,8 @@ EXPORT_SYMBOL(register_console);
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {
+	bool use_device_lock = (console->flags & CON_NBCON) && console->write_atomic;
+	unsigned long flags;
 	int res;
 
 	lockdep_assert_console_list_lock_held();
@@ -3707,8 +3728,18 @@ static int unregister_console_locked(struct console *console)
 	if (!console_is_registered_locked(console))
 		return -ENODEV;
 
+	/*
+	 * Use the driver synchronization to ensure that the hardware is not
+	 * in use while this console transitions to being unregistered.
+	 */
+	if (use_device_lock)
+		console->device_lock(console, &flags);
+
 	hlist_del_init_rcu(&console->node);
 
+	if (use_device_lock)
+		console->device_unlock(console, flags);
+
 	/*
 	 * <HISTORICAL>
 	 * If this isn't the last console and it has CON_CONSDEV set, we

