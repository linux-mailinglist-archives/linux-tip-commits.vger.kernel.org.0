Return-Path: <linux-tip-commits+bounces-7445-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5C2C78531
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 11:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5E7F4EC9AA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 10:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8183451D6;
	Fri, 21 Nov 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fiEW2UFd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EPnwFACH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2634027D;
	Fri, 21 Nov 2025 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719077; cv=none; b=h4bt4n/Mx5KG+hIqjVEqiXipzDjGvJ5Nog1p6E+ICw6igCpwCiWf7S5JfmEjnhM2a+qatBUmH0V5fen37kLpwxLnf6dLtz6gAYTehGUsJLOQ9BrouQBOtHZ4fOQDCOovOahvs/FnmCdI/i+kb1vQlddLd9yYWKw7w5wt5nGjRqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719077; c=relaxed/simple;
	bh=xgnSG5z2zPxoFF2s1SyudIKoOl1SfuM1HTnVJeXYCMo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tVJ0tlouiz8jjQl9btyi87Q/oCVxfVBQvumJOxx3sV9DQRE39AKrNK63fmSWKUTshFpnVJM5n1gFHplGlUuxmAWVCpDLqCC0GtAMdHl8TpQk+v2RgdyavucO5CajkdrZp+xhGj50ano+/42Fp4vLPMjt/JtyhW2BtZX+ZzkdEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fiEW2UFd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EPnwFACH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 09:57:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763719073;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6AddFK0eV/ILx/gMNCjdTPBtv/TNgXoaKasnzaoryk=;
	b=fiEW2UFdnFZCT4qak2KjI8QCn11xawqjSvLt2v1YGfFAn2Qp9tAXJ2dWeHficZky/31iwh
	U3ZA/UOqtYdTyccl5FqJC0JnDt0+kUYsHVLpmPeAKitqv8yxEN9bJS4qSFJhksXX9IUjhs
	sYvCmWn8LaG24J8cmzzOQ6Qp0HuYuBWbhNGgokZezykK+VYPRdGUO95fmDKF33YHiwKbAT
	lDmh4/YQ2NNIN/SZNSpmV2hrX0CxPmttH2KfJzy1y3Xab9YtWLAuEevUvbnJyP4hIYiURc
	ruiHwe9Dk/SoVNb6Z9d2ZYVk4sYFXAdKKLqU+rFpI+qnpjpA771l9R4LitQTqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763719073;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6AddFK0eV/ILx/gMNCjdTPBtv/TNgXoaKasnzaoryk=;
	b=EPnwFACH6ozKcB4SVEiQqRY0+4MeaihYgb1ssSEhB5H5vMmuRJ7x+M+bJ6agHHoIcLHP6/
	sx6ANyDE3/rdYbCQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] tty: amiserial: Fix namespace collision and
 startup() section placement with -ffunction-sections
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <9e56afff5268b0b12b99a8aa9bf244d6ebdcdf47.1763669451.git.jpoimboe@kernel.org>
References:
 <9e56afff5268b0b12b99a8aa9bf244d6ebdcdf47.1763669451.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176371907263.498.16211124701635103033.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     845c09e4744f111eae894ad3b67a369bb43d50fb
Gitweb:        https://git.kernel.org/tip/845c09e4744f111eae894ad3b67a369bb43=
d50fb
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 20 Nov 2025 12:14:18 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 10:04:09 +01:00

tty: amiserial: Fix namespace collision and startup() section placement with =
-ffunction-sections

When compiled with -ffunction-sections (e.g., for LTO, livepatch, dead
code elimination, AutoFDO, or Propeller), the startup() function gets
compiled into the .text.startup section (or in some cases
.text.startup.constprop.0 or .text.startup.isra.0).

However, the .text.startup and .text.startup.* sections are also used by
the compiler for __attribute__((constructor)) code.

This naming conflict causes the vmlinux linker script to wrongly place
startup() function code in .init.text, which gets freed during boot.

Some builds have a mix of objects, both with and without
-ffunctions-sections, so it's not possible for the linker script to
disambiguate with #ifdef CONFIG_FUNCTION_SECTIONS or similar.  This
means that "startup" unfortunately needs to be prohibited as a function
name.

Rename startup() to rs_startup().  For consistency, also rename its
shutdown() counterpart to rs_shutdown().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/9e56afff5268b0b12b99a8aa9bf244d6ebdcdf47.17636=
69451.git.jpoimboe@kernel.org
---
 drivers/tty/amiserial.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 5af4644..81eaca7 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -438,7 +438,7 @@ static irqreturn_t ser_tx_int(int irq, void *dev_id)
  * ---------------------------------------------------------------
  */
=20
-static int startup(struct tty_struct *tty, struct serial_state *info)
+static int rs_startup(struct tty_struct *tty, struct serial_state *info)
 {
 	struct tty_port *port =3D &info->tport;
 	unsigned long flags;
@@ -513,7 +513,7 @@ errout:
  * This routine will shutdown a serial port; interrupts are disabled, and
  * DTR is dropped if the hangup on close termio flag is on.
  */
-static void shutdown(struct tty_struct *tty, struct serial_state *info)
+static void rs_shutdown(struct tty_struct *tty, struct serial_state *info)
 {
 	unsigned long	flags;
=20
@@ -975,7 +975,7 @@ check_and_exit:
 			change_speed(tty, state, NULL);
 		}
 	} else
-		retval =3D startup(tty, state);
+		retval =3D rs_startup(tty, state);
 	tty_unlock(tty);
 	return retval;
 }
@@ -1251,9 +1251,9 @@ static void rs_close(struct tty_struct *tty, struct fil=
e * filp)
 		 */
 		rs_wait_until_sent(tty, state->timeout);
 	}
-	shutdown(tty, state);
+	rs_shutdown(tty, state);
 	rs_flush_buffer(tty);
-	=09
+
 	tty_ldisc_flush(tty);
 	port->tty =3D NULL;
=20
@@ -1325,7 +1325,7 @@ static void rs_hangup(struct tty_struct *tty)
 	struct serial_state *info =3D tty->driver_data;
=20
 	rs_flush_buffer(tty);
-	shutdown(tty, info);
+	rs_shutdown(tty, info);
 	info->tport.count =3D 0;
 	tty_port_set_active(&info->tport, false);
 	info->tport.tty =3D NULL;
@@ -1349,7 +1349,7 @@ static int rs_open(struct tty_struct *tty, struct file =
* filp)
 	port->tty =3D tty;
 	tty->driver_data =3D info;
=20
-	retval =3D startup(tty, info);
+	retval =3D rs_startup(tty, info);
 	if (retval) {
 		return retval;
 	}

