Return-Path: <linux-tip-commits+bounces-7447-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E0EC78493
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 11:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 880512D544
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B27345CD6;
	Fri, 21 Nov 2025 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bv7hyjhO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/se1ttng"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F7A344046;
	Fri, 21 Nov 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719080; cv=none; b=rOAFEskUvsG2reWODDhPOY0Zap+662jUX0DHIXp9JkgFIbT1alOfysRGUMNd7tpCgcXyfQ3+fQIUd7ENznp3xrFWG5oCdTWav6MKqDFEUjiyMGbKDeVGt9fYezH0/znyCcBXtx2ponUcsnUQNIwFzA3FFeU+SRl6n0hQ0IpeOkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719080; c=relaxed/simple;
	bh=zX26LyIoSp4BOIgPUzkqsztntnD97UsoKSKdT4vhBzI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Dz1qO4hg3x9/5JUgGzEL+y95G3Y1WLTt7DezDrQkiYfyHAssT0i4zsGGJSu+DSa/vmDxRv+ehzjRI3NZ3B0hfKSpTRyQtsbD8v4NX34jbdoIST9/tB5CN5D+PhOA7TmZk2OIQVSj/JcqeKFOCIWE8g5Hv+no26z9/bTU1p86LbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bv7hyjhO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/se1ttng; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 09:57:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763719076;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqAtIKfEoHrODFtFqt13xmgL59h5A10AUNA5gKK1EKc=;
	b=bv7hyjhOf9C0VpaD5puGOIsurxAGMt8eCcFugRDLCW1/MakRWHGQ6w298f3Rtqw/PGGogH
	zAPj47SuihFC0owXclHMff3vMJb2chfW1wDH2oW/jlPOK01Jz8OJX5U0I3qpZlpHOC1AjW
	QbZHb9vO4Gqp3gLF9n04wBgj5wKMuI9sWQl0B0i7TMf9MZWEZPDbiaslYuY9YUAOoXaPfh
	aAis6uO1CF+sdFzZeExoPGvpTIgajr5yq6ZTuX+eCJ39latmPNs4pE7aNYMQrzSkKVBIiS
	H342vNGTK94xLU1ap4RZzyH3yWgPlHfiTO4cUEkBglawJ0dCDCr5n0qEz0PmzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763719076;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqAtIKfEoHrODFtFqt13xmgL59h5A10AUNA5gKK1EKc=;
	b=/se1ttng0TjESLM7IvVNplzKEIQqHje/HhKlK4+yKavUm1F8EdWVoc6Nw45F95MuQIze0k
	JXL+nncB3vOmZUCA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] serial: icom: Fix namespace collision and
 startup() section placement with -ffunction-sections
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <1aee9ef69f9d40405676712b34f0c397706e7023.1763669451.git.jpoimboe@kernel.org>
References:
 <1aee9ef69f9d40405676712b34f0c397706e7023.1763669451.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176371907472.498.13259400722255119410.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     da6202139aef11c3c5881176e6e3184d88d8a0d9
Gitweb:        https://git.kernel.org/tip/da6202139aef11c3c5881176e6e3184d88d=
8a0d9
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 20 Nov 2025 12:14:16 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 10:04:09 +01:00

serial: icom: Fix namespace collision and startup() section placement with -f=
function-sections

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

Rename startup() to icom_startup().  For consistency, also rename its
shutdown() counterpart to icom_shutdown().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/1aee9ef69f9d40405676712b34f0c397706e7023.17636=
69451.git.jpoimboe@kernel.org
---
 drivers/tty/serial/icom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 7fb995a..d00903c 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -760,7 +760,7 @@ static void load_code(struct icom_port *icom_port)
 		dma_free_coherent(&dev->dev, 4096, new_page, temp_pci);
 }
=20
-static int startup(struct icom_port *icom_port)
+static int icom_startup(struct icom_port *icom_port)
 {
 	unsigned long temp;
 	unsigned char cable_id, raw_cable_id;
@@ -832,7 +832,7 @@ unlock:
 	return 0;
 }
=20
-static void shutdown(struct icom_port *icom_port)
+static void icom_shutdown(struct icom_port *icom_port)
 {
 	unsigned long temp;
 	unsigned char cmdReg;
@@ -1311,7 +1311,7 @@ static int icom_open(struct uart_port *port)
 	int retval;
=20
 	kref_get(&icom_port->adapter->kref);
-	retval =3D startup(icom_port);
+	retval =3D icom_startup(icom_port);
=20
 	if (retval) {
 		kref_put(&icom_port->adapter->kref, icom_kref_release);
@@ -1333,7 +1333,7 @@ static void icom_close(struct uart_port *port)
 	cmdReg =3D readb(&icom_port->dram->CmdReg);
 	writeb(cmdReg & ~CMD_RCV_ENABLE, &icom_port->dram->CmdReg);
=20
-	shutdown(icom_port);
+	icom_shutdown(icom_port);
=20
 	kref_put(&icom_port->adapter->kref, icom_kref_release);
 }

