Return-Path: <linux-tip-commits+bounces-2260-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369829720E7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F591C23A25
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05BA18DF9E;
	Mon,  9 Sep 2024 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AIepcseD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dZMhaBuu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1864418C356;
	Mon,  9 Sep 2024 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902881; cv=none; b=iLFOPb/bdJwkXQ2Oe3ukNBgb3FQYdY06T001U+7fF7D1SYu6UQdXEWjFg/DBIWaj1VO9Ud6u8ol45iCMmwjWiEHsFPBEQTGHMlr1XHPYwnvVklFyTLID1z4XNFunkBdoHrHwSXDMOEMOoblqKmuvErlRsCWeqb4lTNqxrvcRtN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902881; c=relaxed/simple;
	bh=32cuoAcmoGYCFlU/hD43nyLOyr6T1WO3SrO0XWSA6TU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FkDPfNiKaWMCTs0mISLmv15AWA8A6Gf0Ji7OrSZJ/llq6Gw/PINyNZiuLCWvQcFb4pEIE1O4tV1E8Ou4o8DtSI6DEaNeEFsojNum6zEwp1Pv+mb/5gXZc/DucAIFoyobSs1vwfW3odRzjLoKOs6Cu/gjPhcobzJyZnwiNd6BR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AIepcseD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dZMhaBuu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902877;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ef70IAJmu1sb0x25NrehsUqvdfF+seaba9o1hfa65tA=;
	b=AIepcseDXuaaAZ125mcDlR1CTzkRFDzRMxcWfwS8UlBWVkl2ECEfw2p+wiqyS0yfeYe9PX
	bwg6l8Gp4MG7hvS5cugu/7r/fc72kPnIBfMYvOg24LtLZFXj08Z/F7vIIkVJ5kdP4iOuud
	cGDJsuidKh+2TPKAdSzegtVJk/KmYjYCYJ3DfYYQNdM5XExE4ZXOsVZdk+/15/26oh4eJa
	t5GefGgk2a4/9ShL2RMskxRAodO7XMFps40f8+DGgLzcBMyphNEYmFA+i7TRzValICRkBd
	0RAV6yw/FrcCQvufgpHv/YwHBe9yXw3LUKmY+Yets978EFtj9vpLj5+b7dlNDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902877;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ef70IAJmu1sb0x25NrehsUqvdfF+seaba9o1hfa65tA=;
	b=dZMhaBuu42GEtddQ66xllArF0L3XHM+OEB5QLc45iItmtyrqN72/IRaaK1kvg1W01LxyF3
	otwj0bUd7WpXt/Dw==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/rt] serial: core: Introduce wrapper to set @uart_port->cons
Cc: John Ogness <john.ogness@linutronix.de>, theo.lebrun@bootlin.com,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Petr Mladek <pmladek@suse.com>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-12-john.ogness@linutronix.de>
References: <20240820063001.36405-12-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287667.2215.4144860033353292073.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     eabd4600dafacf9895184259373f2445ff748654
Gitweb:        https://git.kernel.org/tip/eabd4600dafacf9895184259373f2445ff7=
48654
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:37 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:23 +02:00

serial: core: Introduce wrapper to set @uart_port->cons

Introduce uart_port_set_cons() as a wrapper to set @cons of a
uart_port. The wrapper sets @cons under the port lock in order
to prevent @cons from disappearing while another context is
holding the port lock. This is necessary for a follow-up
commit relating to the port lock wrappers, which rely on @cons
not changing between lock and unlock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Tested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> # EyeQ5, AMBA-PL011
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240820063001.36405-12-john.ogness@linutroni=
x.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/serial/8250/8250_core.c |  6 +++---
 drivers/tty/serial/amba-pl011.c     |  2 +-
 drivers/tty/serial/serial_core.c    | 16 ++++++++--------
 include/linux/serial_core.h         | 17 +++++++++++++++++
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/82=
50_core.c
index 29e4b83..5f9f069 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -423,11 +423,11 @@ static int univ8250_console_setup(struct console *co, c=
har *options)
=20
 	port =3D &serial8250_ports[co->index].port;
 	/* link port to console */
-	port->cons =3D co;
+	uart_port_set_cons(port, co);
=20
 	retval =3D serial8250_console_setup(port, options, false);
 	if (retval !=3D 0)
-		port->cons =3D NULL;
+		uart_port_set_cons(port, NULL);
 	return retval;
 }
=20
@@ -485,7 +485,7 @@ static int univ8250_console_match(struct console *co, cha=
r *name, int idx,
 			continue;
=20
 		co->index =3D i;
-		port->cons =3D co;
+		uart_port_set_cons(port, co);
 		return serial8250_console_setup(port, options, true);
 	}
=20
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8b1644f..7d0134e 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2480,7 +2480,7 @@ static int pl011_console_match(struct console *co, char=
 *name, int idx,
 			continue;
=20
 		co->index =3D i;
-		port->cons =3D co;
+		uart_port_set_cons(port, co);
 		return pl011_console_setup(co, options);
 	}
=20
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_cor=
e.c
index 5bea3af..1e3e28e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3176,8 +3176,15 @@ static int serial_core_add_one_port(struct uart_driver=
 *drv, struct uart_port *u
 	state->uart_port =3D uport;
 	uport->state =3D state;
=20
+	/*
+	 * If this port is in use as a console then the spinlock is already
+	 * initialised.
+	 */
+	if (!uart_console_registered(uport))
+		uart_port_spin_lock_init(uport);
+
 	state->pm_state =3D UART_PM_STATE_UNDEFINED;
-	uport->cons =3D drv->cons;
+	uart_port_set_cons(uport, drv->cons);
 	uport->minor =3D drv->tty_driver->minor_start + uport->line;
 	uport->name =3D kasprintf(GFP_KERNEL, "%s%d", drv->dev_name,
 				drv->tty_driver->name_base + uport->line);
@@ -3186,13 +3193,6 @@ static int serial_core_add_one_port(struct uart_driver=
 *drv, struct uart_port *u
 		goto out;
 	}
=20
-	/*
-	 * If this port is in use as a console then the spinlock is already
-	 * initialised.
-	 */
-	if (!uart_console_registered(uport))
-		uart_port_spin_lock_init(uport);
-
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
=20
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 8872cd2..2cf03ff 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -609,6 +609,23 @@ static inline void __uart_port_unlock_irqrestore(struct =
uart_port *up, unsigned=20
 }
=20
 /**
+ * uart_port_set_cons - Safely set the @cons field for a uart
+ * @up:		The uart port to set
+ * @con:	The new console to set to
+ *
+ * This function must be used to set @up->cons. It uses the port lock to
+ * synchronize with the port lock wrappers in order to ensure that the conso=
le
+ * cannot change or disappear while another context is holding the port lock.
+ */
+static inline void uart_port_set_cons(struct uart_port *up, struct console *=
con)
+{
+	unsigned long flags;
+
+	__uart_port_lock_irqsave(up, &flags);
+	up->cons =3D con;
+	__uart_port_unlock_irqrestore(up, flags);
+}
+/**
  * uart_port_lock - Lock the UART port
  * @up:		Pointer to UART port structure
  */

