Return-Path: <linux-tip-commits+bounces-8257-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPs5IW3inWnpSQQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8257-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 18:39:57 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BA418AA3C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 18:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71B0030FAC36
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 17:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBC63A9DAD;
	Tue, 24 Feb 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KHIxvTns";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SaEbdF2w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D73AA1A3;
	Tue, 24 Feb 2026 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954619; cv=none; b=A5JaobLpmzI774VYq4mqbXAGqoTFoyD1UgDz990VrBwHgvzg+xFGPsbaHdDoKgRbATH4D9/j4g6XkHHr+jhu9rNcO8lJn3G3p076tHr0cOEgAShVNXpLV75d9uy1xkpGcwezEQKSKLsaDPBL0woLxWbhczQwPWdAWkfFg/kuQJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954619; c=relaxed/simple;
	bh=b7NoNvHhsmNXPJCuowCD+m0AiNem0IpIOfmERu5ITZ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kFLLWrHqzgu9MIr7LDT4PSeJuQAw2NgQFX1XJ6d2zQd6bLhqkZOqT4ESoc4JR9LbU18T91sCJylGsGG3Rj9MLegnwF7d/y5sT95FoXBjieRoTHr2r7rcAN4i8xVlY/XkAOQLRGvNXpa8hvG2H6+VOplSO+ADe6pi7uj6LbVsBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KHIxvTns; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SaEbdF2w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 17:36:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771954617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1rA5b7X6VmVafeOf+yifeI698nS6LO54q1hUpsdyhE=;
	b=KHIxvTnshQL3sjGqi0W1OpsjkD1Sau3gKEdcUCY4WSvoCXgJ7xHHxB57v+fjXcX1fNvXl9
	pxNHuAJigHfpOEsE6pg3jhBI2tmsxgQ1N3+PvBRjEHlNLyBYUNDdR9yRS0W0QOSZCRVb9Q
	xEcH0M0hD+uVQe0DBayAHpS+3skxbs2WgOw/+ELvIAOzsEyWQRctU1TXHa61BvP+24/uIx
	BdJTEkCVKQr94ngKTZzUUoe02jmqNHG4S52RjEeL6670Uk0qM+2J3+l8YKKqSgVtnPLdmz
	9LnEf7EB0NJIeZIChlQlL3EEbzjIdazrwp6KOiJsFq5djYbK/DBGzDAJ4BuX1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771954617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1rA5b7X6VmVafeOf+yifeI698nS6LO54q1hUpsdyhE=;
	b=SaEbdF2w3KGQ9+HKvc+WD6dNxhfJaQrHeti8Ntao7NczI4z3W0AahTcegHB/7G7Mi5WCo9
	A/LcoLtAyHZKs8Bw==
From: "tip-bot2 for Ioana Ciornei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Revert "irqchip/ls-extirq: Use
 for_each_of_imap_item iterator"
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Thomas Gleixner <tglx@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20260224113610.1129022-2-ioana.ciornei@nxp.com>
References: <20260224113610.1129022-2-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177195461570.1647592.12540380534313768952.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8257-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,nxp.com:email,linutronix.de:dkim,vger.kernel.org:replyto,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9BA418AA3C
X-Rspamd-Action: no action

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     e08f2adcf990b8cf272e90898401a9e481c1c667
Gitweb:        https://git.kernel.org/tip/e08f2adcf990b8cf272e90898401a9e481c=
1c667
Author:        Ioana Ciornei <ioana.ciornei@nxp.com>
AuthorDate:    Tue, 24 Feb 2026 13:36:09 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 24 Feb 2026 18:35:48 +01:00

Revert "irqchip/ls-extirq: Use for_each_of_imap_item iterator"

This reverts commit 3ac6dfe3d7a2396602b67667249b146504dfbd2a.

The ls-extirq uses interrupt-map but it's a non-standard use documented
in fsl,ls-extirq.yaml:

        # The driver(drivers/irqchip/irq-ls-extirq.c) have not use standard DT
        # function to parser interrupt-map. So it doesn't consider '#address-=
size'
        # in parent interrupt controller, such as GIC.
        #
        # When dt-binding verify interrupt-map, item data matrix is spitted at
        # incorrect position. Remove interrupt-map restriction because it alw=
ays
        # wrong.

This means that by using for_each_of_imap_item and the underlying
of_irq_parse_imap_parent() on its interrupt-map property will effectively
break its functionality

Revert the patch making use of for_each_of_imap_item() in ls-extirq.

Fixes: 3ac6dfe3d7a2 ("irqchip/ls-extirq: Use for_each_of_imap_item iterator")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Acked-by: Herve Codina <herve.codina@bootlin.com>
Link: https://patch.msgid.link/20260224113610.1129022-2-ioana.ciornei@nxp.com
---
 drivers/irqchip/irq-ls-extirq.c | 47 ++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index a7e9c38..96f9c20 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -125,32 +125,45 @@ static const struct irq_domain_ops extirq_domain_ops =
=3D {
 static int
 ls_extirq_parse_map(struct ls_extirq_data *priv, struct device_node *node)
 {
-	struct of_imap_parser imap_parser;
-	struct of_imap_item imap_item;
+	const __be32 *map;
+	u32 mapsize;
 	int ret;
=20
-	ret =3D of_imap_parser_init(&imap_parser, node, &imap_item);
-	if (ret)
-		return ret;
+	map =3D of_get_property(node, "interrupt-map", &mapsize);
+	if (!map)
+		return -ENOENT;
+	if (mapsize % sizeof(*map))
+		return -EINVAL;
+	mapsize /=3D sizeof(*map);
=20
-	for_each_of_imap_item(&imap_parser, &imap_item) {
+	while (mapsize) {
 		struct device_node *ipar;
-		u32 hwirq;
-		int i;
+		u32 hwirq, intsize, j;
=20
-		hwirq =3D imap_item.child_imap[0];
-		if (hwirq >=3D MAXIRQ) {
-			of_node_put(imap_item.parent_args.np);
+		if (mapsize < 3)
+			return -EINVAL;
+		hwirq =3D be32_to_cpup(map);
+		if (hwirq >=3D MAXIRQ)
 			return -EINVAL;
-		}
 		priv->nirq =3D max(priv->nirq, hwirq + 1);
=20
-		ipar =3D of_node_get(imap_item.parent_args.np);
-		priv->map[hwirq].fwnode =3D of_fwnode_handle(ipar);
+		ipar =3D of_find_node_by_phandle(be32_to_cpup(map + 2));
+		map +=3D 3;
+		mapsize -=3D 3;
+		if (!ipar)
+			return -EINVAL;
+		priv->map[hwirq].fwnode =3D &ipar->fwnode;
+		ret =3D of_property_read_u32(ipar, "#interrupt-cells", &intsize);
+		if (ret)
+			return ret;
+
+		if (intsize > mapsize)
+			return -EINVAL;
=20
-		priv->map[hwirq].param_count =3D imap_item.parent_args.args_count;
-		for (i =3D 0; i < priv->map[hwirq].param_count; i++)
-			priv->map[hwirq].param[i] =3D imap_item.parent_args.args[i];
+		priv->map[hwirq].param_count =3D intsize;
+		for (j =3D 0; j < intsize; ++j)
+			priv->map[hwirq].param[j] =3D be32_to_cpup(map++);
+		mapsize -=3D intsize;
 	}
 	return 0;
 }

