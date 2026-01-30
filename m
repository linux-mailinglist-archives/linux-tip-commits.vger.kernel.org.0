Return-Path: <linux-tip-commits+bounces-8145-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIKoBxZnfGk/MQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8145-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 09:08:54 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3CFB82C5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 09:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0490E3004DC3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 08:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49CD313287;
	Fri, 30 Jan 2026 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uyeOSyPs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zC4rYbZM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB5328626;
	Fri, 30 Jan 2026 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769760531; cv=none; b=Pxy8bcOjDY3yPJVStlaq53E4cIEruo5q36dxr7m8rShZ4uyopz92Q05L70OiqsdETjNCMCeV4OURqDIApXSkNRkiUTMqB6QPHstScnHVB7NKoTFiTCNMGSCK0N8BnAZWxLTsL1KDuOzrduUkVheMcDd0j261jVHJKg0IvaKCTIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769760531; c=relaxed/simple;
	bh=dKMoIFJyJjZyPZugm1/nfKqaFbGdvHNWyHwldrpxi1o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H0J//Nx5c2X1O0nStFtTLNcsWsECpDgevN8s2n2S++AaD8Bj70rVZsQl0M/MzMxYu/KaQXB4XexoQrqiT1qXHXxc3NN2q5f1bLwwGP/RVgg1z8ygLtrt3g70PHkzpCRX3Sr4wxU/RANx6VL9UJmydnt/JaHzZUZyxnZLNcSYQmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uyeOSyPs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zC4rYbZM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 30 Jan 2026 08:08:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769760528;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYKQXCJpqYI1j2PyM5vE8OsgeNkgmxRkFYTvjh0UCrA=;
	b=uyeOSyPsSEGtAWHBiOmve5Yj6UjJ77t8cKKc+1B2g6XNUOduEOKNNFc6PH+NlPrKMDcw77
	YI/TTb7eBdgnENA5uPBckNzn3g9cEmiIJ8QiYlPzz5aiP6bKwGi7hWMwTsFVSi5XfPWC5P
	Ky6aJc9F96CQP3xTs6srOnJS4oZ+oXLG7zXoOBbGa9yciKMM1e2c8xWlrznJbP9UONBpnD
	S3c6C/at+lhgCYYJbgmB1e+heQWNnbsIwLG+LBhPEQbu6WACHTwdSmOx9lQhDFS30z8+Mp
	Kx9EqUDmYHEjH9eY84N5h3JY5LFtV7WmRD24zR6ZnVz/Yu5niAQTT1iRPdqCMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769760528;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYKQXCJpqYI1j2PyM5vE8OsgeNkgmxRkFYTvjh0UCrA=;
	b=zC4rYbZMfV86TDvSvq69lK4ProeE/btDWX8pqV4Gid0lU6JSRtsXDgPgmTVeDWubpZAWn5
	zOyrgmruCYYCAhAA==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/proc: Replace snprintf with strscpy in
 register_handler_proc
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20260127224949.441391-2-thorsten.blum@linux.dev>
References: <20260127224949.441391-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176976052681.2495410.16981592964874469903.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8145-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linutronix.de:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 9C3CFB82C5
X-Rspamd-Action: no action

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2dfc417414c6eea4e167b2f46283cded846c531a
Gitweb:        https://git.kernel.org/tip/2dfc417414c6eea4e167b2f46283cded846=
c531a
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Tue, 27 Jan 2026 23:49:49 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 30 Jan 2026 08:53:53 +01:00

genirq/proc: Replace snprintf with strscpy in register_handler_proc

Replace snprintf("%s", ...) with the faster and more direct strscpy().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260127224949.441391-2-thorsten.blum@linux.dev
---
 kernel/irq/proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 77258ea..b0999a4 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <linux/mutex.h>
+#include <linux/string.h>
=20
 #include "internals.h"
=20
@@ -317,7 +318,7 @@ void register_handler_proc(unsigned int irq, struct irqac=
tion *action)
 	if (!desc->dir || action->dir || !action->name || !name_unique(irq, action))
 		return;
=20
-	snprintf(name, MAX_NAMELEN, "%s", action->name);
+	strscpy(name, action->name);
=20
 	/* create /proc/irq/1234/handler/ */
 	action->dir =3D proc_mkdir(name, desc->dir);

