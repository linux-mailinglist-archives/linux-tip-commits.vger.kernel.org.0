Return-Path: <linux-tip-commits+bounces-8236-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDNNMZFRnWkoOgQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8236-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 08:21:53 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E02182F0A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 08:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFE0B3070949
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 07:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED683644A3;
	Tue, 24 Feb 2026 07:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KM/OouJp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LOxaD4LP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9454B364059;
	Tue, 24 Feb 2026 07:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771917632; cv=none; b=m8DPwrdvAnndvTOFj+rOUuRNHngBwIHia0+NmqLf8SdJh71Y7AHMGXF0n98l2dpZrNxmXbnqCFZfdJhvdh4Zr4qC8PVK/W5WmR777s8me7DKc7LD5AxFlbuOi1NBhDZHSHp1cJfPl/ct2QDNY6+f1FTnHjMW9Y/wgMK6yqy6BkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771917632; c=relaxed/simple;
	bh=soyizRFvc8Ai96gNdDIYuKnfUqtHoH+9itZXLP/adMQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Qkbyv5Kb6TGdlJJVzb+tLn7J25QzWjPy59KrTfI1V01qRtA0AVEsQsBtCjFVlIg5p7Q1nunPjPa56hyuTYGmiGS0uhyzo2KCNcRKka5z9LFKS/eQvuAQ0HpW3ZiwgKLkMktX5lYeazvNbmNoI/JZmInnRjyxQ4sYAssouYnT94I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KM/OouJp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LOxaD4LP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 07:20:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771917623;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uo0OD84mbt4AcAgYsyRRUJuPDHvYpfNJhxGRXUoDnHM=;
	b=KM/OouJpbnqiHOl1AEc0/+/665INb9+jm2r5Zvs6D15P3CFXUXR6A4lbp1ZghvLbl6aqPX
	m79FXNVKH0NjJfHRwWLq/GzvFFq6vJUzcVrYKMCxNtuzXBK0UMm4d53HuaFfqlLI18qT+0
	2Q1tE7/s2PZHM/+3SRITM28k+p4CvhGF8FGJqgKokrXZajUhQjWfXz2+4qihv52Jx/K0Ll
	JhsMEBRU94NAsPOu65yVNZ2+URe1D6CciQIjGuJJZMj/HnhcDtBKXp4zDtj1Z4mGT6Mz+v
	49FVNWMi4gEH7u4YsHMRJxZUVEb1kzT1YZEMtIs0sq3j5zD0lr2w7PM8c5r51Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771917623;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uo0OD84mbt4AcAgYsyRRUJuPDHvYpfNJhxGRXUoDnHM=;
	b=LOxaD4LPVDku7mGwQdGCVLuV6ueDk/hevOl2iKgfD55UDFBqwV46PsBBcM6xxtwgU+nqqU
	qv36lXhqvsxvmwBw==
From: "tip-bot2 for Brian Masney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/irq-pic32-evic: Allow driver to be
 compiled with COMPILE_TEST
Cc: Brian Masney <bmasney@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260222-irqchip-pic32-v1-5-37f50d1f14af@redhat.com>
References: <20260222-irqchip-pic32-v1-5-37f50d1f14af@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177191762232.1647592.12226181922052791001.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8236-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linutronix.de:dkim,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 41E02182F0A
X-Rspamd-Action: no action

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     4b52df1b4e1d9cf4cb5a8e1b5287d1e3d1a6aa0c
Gitweb:        https://git.kernel.org/tip/4b52df1b4e1d9cf4cb5a8e1b5287d1e3d1a=
6aa0c
Author:        Brian Masney <bmasney@redhat.com>
AuthorDate:    Sun, 22 Feb 2026 18:43:48 -05:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 24 Feb 2026 08:15:44 +01:00

irqchip/irq-pic32-evic: Allow driver to be compiled with COMPILE_TEST

This driver currently only supports builds against a PIC32 target. To avoid
future breakage in the future update Kconfig so that it can be built with
COMPILE_TEST enabled.

[ tglx: Drop the now pointless select in the pic32 Kconfig ]

Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260222-irqchip-pic32-v1-5-37f50d1f14af@redha=
t.com
---
 arch/mips/pic32/Kconfig | 1 -
 drivers/irqchip/Kconfig | 5 ++++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pic32/Kconfig b/arch/mips/pic32/Kconfig
index bb6ab1f..cd14a07 100644
--- a/arch/mips/pic32/Kconfig
+++ b/arch/mips/pic32/Kconfig
@@ -20,7 +20,6 @@ config PIC32MZDA
 	select LIBFDT
 	select USE_OF
 	select PINCTRL
-	select PIC32_EVIC
 	help
 	  Support for the Microchip PIC32MZDA microcontroller.
=20
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f07b00d..dc26eff 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -252,9 +252,12 @@ config ORION_IRQCHIP
 	select IRQ_DOMAIN
=20
 config PIC32_EVIC
-	bool
+	def_bool MACH_PIC32 || COMPILE_TEST
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
+	help
+	  Enable support for the interrupt controller on the Microchip PIC32
+	  family of platforms.
=20
 config JCORE_AIC
 	bool "J-Core integrated AIC" if COMPILE_TEST

