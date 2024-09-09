Return-Path: <linux-tip-commits+bounces-2261-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82B09720E8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63971C23B09
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3FE18E04B;
	Mon,  9 Sep 2024 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NnKwWbbT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AUN1A622"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD5518C015;
	Mon,  9 Sep 2024 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902881; cv=none; b=BsXfMLNcTfe8o+cBdo2DtmYbABuRlpmlm/yGExjTg5czsXwv/GcEgawwh5YpX/aXf1VwgekIsUPGK76EKYIXkK7Ney1mV6mxGljnVzIVVXU/WgE7WDRBz5p+y4uqaADHCoYQhCaI18/LAmvdVekJQEf7se5vMln/WgLWOK/aAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902881; c=relaxed/simple;
	bh=Br4wTuQGSmfxOvDW72FjvwCeKQaIAnPB5U2P6TEACPE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eAWQuzFkY9uooUfUYyh8x1rqP8HqcPioOm5ZvADz64fBYcC88uAlqc+br31qqnBYW62SPJGw8qErgd80lMZQGF9O00MMCJKCxSlwNByMvvF4af7U4x3NfjtDb89Rl2La6jg/kEr37yv7VOjTAJDU3y8SK0hCePedBrwdo6ZkeGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NnKwWbbT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AUN1A622; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLYswB349NoAsU31BHwx7fBPNvPLJQ5gi5C+bmllcKk=;
	b=NnKwWbbTc6qLm6BsLm8GtrYq8+WJlxxAIaCDBYlwtwOp3KQubI/oEf7BDLjLaHBZK5N+ag
	vupNGlMyYAHioA9GjMwz69WkzuqZ7oW8+deAyXyZNwNvWbBRDrvLfdhLOgTZLmDqulckqe
	A6q3mLKV8wWjJdQbpUb0M6CptedZeOjWAPHzUco4G0cYc42jyELPeecJKehuxGaARophlO
	EdVpSG3QYSshd+IXGaYQKCDsb1+TpyjhA98s450L81pJ4TblY9IN5Aa7n+qtvx0kNB2O/2
	xs+UiyxlCSRtgdl1fhDkotyMthXACUyjmkolyv6r9JKPPp7PYLJKQ8M0hTva/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLYswB349NoAsU31BHwx7fBPNvPLJQ5gi5C+bmllcKk=;
	b=AUN1A622kpn4fxL5SjkXyePjG7zRQvScM9PW1prSgiO/QWyXiXECTg1ogC8k4k6i134bgz
	pxwyyQJsPo2ACyDw==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/rt] serial: core: Acquire nbcon context in port->lock wrapper
Cc: John Ogness <john.ogness@linutronix.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Petr Mladek <pmladek@suse.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-15-john.ogness@linutronix.de>
References: <20240820063001.36405-15-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287552.2215.17280011412309920521.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     4126f149c48b2ae757d11ea24675f7071ab22ebf
Gitweb:        https://git.kernel.org/tip/4126f149c48b2ae757d11ea24675f7071ab22ebf
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:40 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:23 +02:00

serial: core: Acquire nbcon context in port->lock wrapper

Currently the port->lock wrappers uart_port_lock(),
uart_port_unlock() (and their variants) only lock/unlock
the spin_lock.

If the port is an nbcon console that has implemented the
write_atomic() callback, the wrappers must also acquire/release
the console context and mark the region as unsafe. This allows
general port->lock synchronization to be synchronized against
the nbcon write_atomic() callback.

Note that __uart_port_using_nbcon() relies on the port->lock
being held while a console is added and removed from the
console list (i.e. all uart nbcon drivers *must* take the
port->lock in their device_lock() callbacks).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-15-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/serial_core.h | 82 +++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 2cf03ff..4ab6587 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -11,6 +11,8 @@
 #include <linux/compiler.h>
 #include <linux/console.h>
 #include <linux/interrupt.h>
+#include <linux/lockdep.h>
+#include <linux/printk.h>
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/tty.h>
@@ -625,6 +627,60 @@ static inline void uart_port_set_cons(struct uart_port *up, struct console *con)
 	up->cons = con;
 	__uart_port_unlock_irqrestore(up, flags);
 }
+
+/* Only for internal port lock wrapper usage. */
+static inline bool __uart_port_using_nbcon(struct uart_port *up)
+{
+	lockdep_assert_held_once(&up->lock);
+
+	if (likely(!uart_console(up)))
+		return false;
+
+	/*
+	 * @up->cons is only modified under the port lock. Therefore it is
+	 * certain that it cannot disappear here.
+	 *
+	 * @up->cons->node is added/removed from the console list under the
+	 * port lock. Therefore it is certain that the registration status
+	 * cannot change here, thus @up->cons->flags can be read directly.
+	 */
+	if (hlist_unhashed_lockless(&up->cons->node) ||
+	    !(up->cons->flags & CON_NBCON) ||
+	    !up->cons->write_atomic) {
+		return false;
+	}
+
+	return true;
+}
+
+/* Only for internal port lock wrapper usage. */
+static inline bool __uart_port_nbcon_try_acquire(struct uart_port *up)
+{
+	if (!__uart_port_using_nbcon(up))
+		return true;
+
+	return nbcon_device_try_acquire(up->cons);
+}
+
+/* Only for internal port lock wrapper usage. */
+static inline void __uart_port_nbcon_acquire(struct uart_port *up)
+{
+	if (!__uart_port_using_nbcon(up))
+		return;
+
+	while (!nbcon_device_try_acquire(up->cons))
+		cpu_relax();
+}
+
+/* Only for internal port lock wrapper usage. */
+static inline void __uart_port_nbcon_release(struct uart_port *up)
+{
+	if (!__uart_port_using_nbcon(up))
+		return;
+
+	nbcon_device_release(up->cons);
+}
+
 /**
  * uart_port_lock - Lock the UART port
  * @up:		Pointer to UART port structure
@@ -632,6 +688,7 @@ static inline void uart_port_set_cons(struct uart_port *up, struct console *con)
 static inline void uart_port_lock(struct uart_port *up)
 {
 	spin_lock(&up->lock);
+	__uart_port_nbcon_acquire(up);
 }
 
 /**
@@ -641,6 +698,7 @@ static inline void uart_port_lock(struct uart_port *up)
 static inline void uart_port_lock_irq(struct uart_port *up)
 {
 	spin_lock_irq(&up->lock);
+	__uart_port_nbcon_acquire(up);
 }
 
 /**
@@ -651,6 +709,7 @@ static inline void uart_port_lock_irq(struct uart_port *up)
 static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
 {
 	spin_lock_irqsave(&up->lock, *flags);
+	__uart_port_nbcon_acquire(up);
 }
 
 /**
@@ -661,7 +720,15 @@ static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *f
  */
 static inline bool uart_port_trylock(struct uart_port *up)
 {
-	return spin_trylock(&up->lock);
+	if (!spin_trylock(&up->lock))
+		return false;
+
+	if (!__uart_port_nbcon_try_acquire(up)) {
+		spin_unlock(&up->lock);
+		return false;
+	}
+
+	return true;
 }
 
 /**
@@ -673,7 +740,15 @@ static inline bool uart_port_trylock(struct uart_port *up)
  */
 static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long *flags)
 {
-	return spin_trylock_irqsave(&up->lock, *flags);
+	if (!spin_trylock_irqsave(&up->lock, *flags))
+		return false;
+
+	if (!__uart_port_nbcon_try_acquire(up)) {
+		spin_unlock_irqrestore(&up->lock, *flags);
+		return false;
+	}
+
+	return true;
 }
 
 /**
@@ -682,6 +757,7 @@ static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long
  */
 static inline void uart_port_unlock(struct uart_port *up)
 {
+	__uart_port_nbcon_release(up);
 	spin_unlock(&up->lock);
 }
 
@@ -691,6 +767,7 @@ static inline void uart_port_unlock(struct uart_port *up)
  */
 static inline void uart_port_unlock_irq(struct uart_port *up)
 {
+	__uart_port_nbcon_release(up);
 	spin_unlock_irq(&up->lock);
 }
 
@@ -701,6 +778,7 @@ static inline void uart_port_unlock_irq(struct uart_port *up)
  */
 static inline void uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
 {
+	__uart_port_nbcon_release(up);
 	spin_unlock_irqrestore(&up->lock, flags);
 }
 

