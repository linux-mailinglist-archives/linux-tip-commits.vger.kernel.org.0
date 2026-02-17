Return-Path: <linux-tip-commits+bounces-8217-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMaaFlE+lGmYBAIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8217-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Feb 2026 11:09:21 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8913B14AB31
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Feb 2026 11:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A116300B061
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Feb 2026 10:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24F02DAFBB;
	Tue, 17 Feb 2026 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RCf7dYd3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZqY4U0Uk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AFA29D297;
	Tue, 17 Feb 2026 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771322958; cv=none; b=A3B7DEqWumh4WYCOIG+KiVMw4b3RPp2GZshhpGJ5t5yvEMfqeRpLD1kT5T1e9VOyFl2/DOAPcLYUdjWjmShSavWQhigc/2XfzA/YfOCJpeB73OkvK5n0osYpPsMIf1XlRSPC/1cnOpGUC1oGqKFbQlrp/8kuGnA9MJAbdqjNbWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771322958; c=relaxed/simple;
	bh=xXp05miHqmPERtTp1mAXbKNomfSJ+sXUSMuVumvgidE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hZWMZrTnSw4iLwPK2HIgHqyq/QCK7Ez4C9i5iO1kAk/2WlLtHgJLMvHK6OlGZx2eg/1EtZp2NYVgjymmIfUnHSBadny837fFX5ykuigk95PaMeY5MtCKetRvXVwzX3pnKWcJoydE0M6WY0Yxlf96AtxG/RjE6d80xuO/3+HHl4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RCf7dYd3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZqY4U0Uk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Feb 2026 10:09:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771322956;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tT18EnlUrrDW4qV48pOfsCzTbf7kyHbZHoJiqHhCbJQ=;
	b=RCf7dYd3Dt2UB3GpP6RdhLu8EnYwE6M7Mwd/fL4L0j7Fu2N+xobbsWbjka5p5FZlQsjRXI
	lA5VnL59MsWGG8IPk8RxtCau2w6jOUhsPtQpbIX7kcbTzlOZRb8zq6VmsBAjbbI11SjoVZ
	mkCGjOELVm3f7ESi1x0q05FxeEMWS281sW00WF/3K2gxeuPbLCBy6EytE6YCyRF8cWjcs5
	A6kHviUUhFxrCyHIElbZ1CCMT6eNUjOqAOJaq6D4aKn6TPk+mxa7UaqTUzE2pQ+51YS0L5
	yXmXHhJBcBkHrDHP6qRNehDx5VDBEUtFVfmrr3eSEEMcsRmMdU5TQ1Kqy5+2XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771322956;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tT18EnlUrrDW4qV48pOfsCzTbf7kyHbZHoJiqHhCbJQ=;
	b=ZqY4U0UkkrfCpAmcA7LwlMewP+THsza53hkQSS0zs87hkweMeskNAHizQX91zoqErxjrdg
	+hjaquD8ZZnXOkDw==
From: "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/mmp: Make icu_irq_chip variable static const
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20260216110449.160277-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260216110449.160277-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177132295457.542.14817435678729014942.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,qualcomm.com:email,linutronix.de:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8217-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 8913B14AB31
X-Rspamd-Action: no action

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     f0617176be5e497b67b3c87bac35b26ebccac499
Gitweb:        https://git.kernel.org/tip/f0617176be5e497b67b3c87bac35b26ebcc=
ac499
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
AuthorDate:    Mon, 16 Feb 2026 12:04:50 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 17 Feb 2026 11:03:56 +01:00

irqchip/mmp: Make icu_irq_chip variable static const

File-scope 'icu_irq_chip' is not used outside of this unit and is not
modified anywhere, so make it static const to silence sparse warning:

  irq-mmp.c:139:17: warning: symbol 'icu_irq_chip' was not declared. Should i=
t be static?

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260216110449.160277-2-krzysztof.kozlowski@os=
s.qualcomm.com
---
 drivers/irqchip/irq-mmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 09e6404..8e210cb 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -136,7 +136,7 @@ static void icu_unmask_irq(struct irq_data *d)
 	}
 }
=20
-struct irq_chip icu_irq_chip =3D {
+static const struct irq_chip icu_irq_chip =3D {
 	.name		=3D "icu_irq",
 	.irq_mask	=3D icu_mask_irq,
 	.irq_mask_ack	=3D icu_mask_ack_irq,

