Return-Path: <linux-tip-commits+bounces-8160-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ibylGKd7f2mlrwIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8160-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 17:13:27 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A72BAC6647
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 17:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7E0E3004F56
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 16:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AA21DC985;
	Sun,  1 Feb 2026 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WvZlFTti";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jk9D7lpG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679D155389;
	Sun,  1 Feb 2026 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769962402; cv=none; b=J8L6aX7HRTpVH7RBIai632aymKzHa+w8zLuNrT/f+uSefqqOCoAcmf+49ZG9vDM5uYyFA6viFYcef/7WryBHmzH2grmZgYmNdsn2DOakaJHPN/d5AfpcqBcb7GcV6QCoy5unYZ+0eIIs9fb2PZ470duqpJd7pFoKX4uzRKjhEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769962402; c=relaxed/simple;
	bh=QaKxZT0e8DIe8baGgYrcc3LEkNQOJ9Tu3RSVnKI+YEg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jLyH+aPT2UoDMqhjg1H9h5J8N2cj/NwkmAIADUzL1Fuv78FrrhE8QuygP1GvW037e7OwTIgx6AUhk/JmGvF8yDQRvLm4lJtohPVdbYZ34oMhenoBSP5636Nish+7ibAyyS60V9T2C8+eAJt+FqvAvGj+XCobMWu3N1ZGfPgxz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WvZlFTti; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jk9D7lpG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 16:13:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769962399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3PaV4KrTLazUjXCo8r7+dae3r4m75SDFDkok4YgazE=;
	b=WvZlFTtimknVfeB+JANm9pVZBmsUeUSitvlQa7tSu+zXknq4Fq16OOvbXPm7o8YqVMal9U
	lrZZpZShleiL2S9yqoubiNqOcFzmjsfHtFpIp8EZc3N5EsO2zorC/I6k2GDRRNlpAGvV+C
	oakZTQvgPo6fskmFjnF1svmogU6WsY4ii9a+TCWzPc2j6jBmtR1ZLCf8gxPkyzQdqB0pOM
	TViT5KbN7FnhcF0ruL8G7mXkfs4r0XkMx40p2ryS7RMPbH+yHQFKjAzDMxOJ3V7gZxMHkx
	uLCiUwb6fk0lJ+8vX7eAjTZmuATDVXNZPmFxC/Bev2USjctEBrGf0x2Gs+e+Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769962399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3PaV4KrTLazUjXCo8r7+dae3r4m75SDFDkok4YgazE=;
	b=jk9D7lpGpi/MrkPRtv6Eu+GC2n6UDENyHMo0eiikpJISmfwSzP4yG/3kSvzWDvSFV4dASV
	I+lC4SxquS0ci5Dw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/aspeed-scu-ic: Remove unused variable mask
Cc: kernel test robot <lkp@intel.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <874io0h3sz.ffs@tglx>
References: <874io0h3sz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996239745.2495410.16110856577487908883.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8160-lists,linux-tip-commits=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email,linutronix.de:dkim]
X-Rspamd-Queue-Id: A72BAC6647
X-Rspamd-Action: no action

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     e1f94662d759411fb7da3e4e662ec588c268e1a5
Gitweb:        https://git.kernel.org/tip/e1f94662d759411fb7da3e4e662ec588c26=
8e1a5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 01 Feb 2026 16:38:36 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:07:03 +01:00

irqchip/aspeed-scu-ic: Remove unused variable mask

The kernel test robot reports:

  drivers/irqchip/irq-aspeed-scu-ic.c:107:27: warning: variable 'mask' set bu=
t not used
     107 |         unsigned int sts, mask;

Remove the leftover.

Fixes: b2a0c13f8b4f ("irqchip/aspeed-scu-ic: Add support for AST2700 SCU inte=
rrupt controllers")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/874io0h3sz.ffs@tglx
Closes: https://lore.kernel.org/oe-kbuild-all/202602010957.9uuKqUkG-lkp@intel=
.com/
---
 drivers/irqchip/irq-aspeed-scu-ic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed=
-scu-ic.c
index bee59c8..7398c3b 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -104,11 +104,10 @@ static void aspeed_scu_ic_irq_handler_split(struct irq_=
desc *desc)
 	struct aspeed_scu_ic *scu_ic =3D irq_desc_get_handler_data(desc);
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
 	unsigned long bit, enabled, max, status;
-	unsigned int sts, mask;
+	unsigned int sts;
=20
 	chained_irq_enter(chip, desc);
=20
-	mask =3D scu_ic->irq_enable;
 	sts =3D readl(scu_ic->base + scu_ic->isr);
 	enabled =3D sts & scu_ic->irq_enable;
 	sts =3D readl(scu_ic->base + scu_ic->isr);

