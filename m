Return-Path: <linux-tip-commits+bounces-6234-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C553B1B043
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Aug 2025 10:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD241896D1F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Aug 2025 08:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7DD2494C2;
	Tue,  5 Aug 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sj80Gu+b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7nBPIPXS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B5B1C84B8;
	Tue,  5 Aug 2025 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383041; cv=none; b=KniXWG9OnKSDX22PrwyZHozU0HOt0QNRyL+eemZmRyKXogXRftTwv1eMq1roccmGP823c2FGCThDs7z/oPN/od1jrXPcDCwJ/kk5n667RkwUfqi3B4QuVlRaC8ox5MElKiSAxZHWseyFMxSpRuYYrg708wKdzXX6qrrNvNnlWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383041; c=relaxed/simple;
	bh=ycTFVO2eli16Sehsq7jf8kQ4EW/YUlaP7M+S9niIsqM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SkuSnbUOAT10PKWcGVIbZ9Hyk+K9IIyMYC56uI/wLs6yxHKcsA+XEAfmeLXyaeeujg47v5xwjA7YTReKNOt5uQP7Q0hfFYBDZCeNOhcjBzH4Nb9llK3rm9yQ26nfRDinfAL8eAhZPWvjLoFDzAjlPeQYlaGcYnhBW9sIov96nHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sj80Gu+b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7nBPIPXS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 05 Aug 2025 08:37:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754383036;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly0sV91z6M6CiSCc+xuzq4FlZFDSMDoaxLRn2VEdW7Y=;
	b=Sj80Gu+bP0a16NpIkyO0RgMo19W2XpBjXX/7XqdqnQFVBkL8P/Vxrn5/jSBJdF+8YANeKk
	B4w0+mwL87hmDys8evc91V1UXA2mphMEJ4U8n8Z6/cg7tsRcg6eGvqhstvQKR9dt5PHVtm
	DMR6BcPMALO/aku06GbU9kbjTYmbdmwdcCK5WPQt/qG3FqtacIMfL8MbehDXY29zzxQzLI
	IvDcUh7doBMGc2ojuvRviPDq3o926pPx819lDzlQP79pgYYtteIIg+No9fMVwi/fpxp0No
	6eCrrzCFmknL3n+D4jqR+E25LKiSVVQZBJwwMU2c2fzs8OmhHY2rXgYWswMjxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754383036;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly0sV91z6M6CiSCc+xuzq4FlZFDSMDoaxLRn2VEdW7Y=;
	b=7nBPIPXS5GsE1GweOkl8JULltluIycCA82TIsSZMbIBfXTpCljRX2Cueer61Pqcop5pUo/
	OAL+XImE8XvU6fCg==
From: "tip-bot2 for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/msi-lib: Fix fwnode refcount in
 msi_lib_irq_domain_select()
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250804145553.795065-1-lpieralisi@kernel.org>
References: <20250804145553.795065-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175438303167.1420.5717276327513012044.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     02cbf8e0692bd30717b35a3ff5e46460d1d5d471
Gitweb:        https://git.kernel.org/tip/02cbf8e0692bd30717b35a3ff5e46460d1d=
5d471
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Mon, 04 Aug 2025 16:55:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 05 Aug 2025 10:31:46 +02:00

irqchip/msi-lib: Fix fwnode refcount in msi_lib_irq_domain_select()

Commit 8b65db1e93a2 ("irqchip/msi-lib: Add IRQ_DOMAIN_FLAG_FWNODE_PARENT
handling") added logic in msi_lib_irq_domain_select() to match the domain
fwnode against the fwnode parent of the fwspec.fwnode.

The fwnode_get_parent() caller must call fwnode_handle_put() on the
returned pointer value, lest fwnode refcounting for the parent ends up
being out of kilter.

Fix this by relying on the fwnode_handle clean-up handlers and by
incrementing the fwnode refcount regardless of whether parent matching is
used or not (the domain selection code already holds a reference before
calling msi_lib_irq_domain_select() but to make the exit path more uniform
if IRQ_DOMAIN_FLAG_FWNODE_PARENT is not set fwnode_handle_get() is called
again on fwspec.fwnode so that the clean-up code is the same for the two
matching patterns).

Fixes: 8b65db1e93a2 ("irqchip/msi-lib: Add IRQ_DOMAIN_FLAG_FWNODE_PARENT hand=
ling")
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250804145553.795065-1-lpieralisi@kernel.o=
rg
---
 drivers/irqchip/irq-msi-lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 454c7f1..9089440 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -133,13 +133,13 @@ int msi_lib_irq_domain_select(struct irq_domain *d, str=
uct irq_fwspec *fwspec,
 {
 	const struct msi_parent_ops *ops =3D d->msi_parent_ops;
 	u32 busmask =3D BIT(bus_token);
-	struct fwnode_handle *fwh;
=20
 	if (!ops)
 		return 0;
=20
-	fwh =3D d->flags & IRQ_DOMAIN_FLAG_FWNODE_PARENT ? fwnode_get_parent(fwspec=
->fwnode)
-						       : fwspec->fwnode;
+	struct fwnode_handle *fwh __free(fwnode_handle) =3D
+		d->flags & IRQ_DOMAIN_FLAG_FWNODE_PARENT ? fwnode_get_parent(fwspec->fwnod=
e)
+							 : fwnode_handle_get(fwspec->fwnode);
 	if (fwh !=3D d->fwnode || fwspec->param_count !=3D 0)
 		return 0;
=20

