Return-Path: <linux-tip-commits+bounces-7768-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FC8CCDFF2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Dec 2025 00:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF9E5300E3E3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 23:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C746681ACA;
	Thu, 18 Dec 2025 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hx4tTI9N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I6iL4Vwu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AE8249EB;
	Thu, 18 Dec 2025 23:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766101469; cv=none; b=nMTLx3IPlfrqjQ6vIUDf9cWGH3RUmglBJjQwPy8jaAza9aP41/rfhRiZ2Bn8jQp5rhayLKoxe9tT2sWKws5oR35CoQzHRnDXgcrfRW/SPTb391TWlBy/inEedol+/OmaQ6PsxCK0aOTYyeAk/9j/CjY3wz4klu0LoqdbjrH322Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766101469; c=relaxed/simple;
	bh=ETASwGxNNN2X+HlTkDn9owfC9Mabph+aBnt4BFEmmNg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QahzJ9shi3zYIfeDYgB8BTKkvPjuMviBJ/e6BoDoEWyDYw0Aw6YfHxzsC/e8w7cZYvASh0s5MKDqklXVHqy+89fIVRD1MjVq3qPOwLsohjVUxEv4sFKgxgZwZDd5ifz2hb62tCw0h1uyc+75svfbxRIcpcremKYqna5sq1u+xZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hx4tTI9N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I6iL4Vwu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Dec 2025 23:44:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766101465;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vyZX7pvFq661JHgUNfA93rfIGVzjF+QdIzBXTL+r/k=;
	b=hx4tTI9NWvcpYMrfwlkk43EXoGacxNyosVhCBHRGcgraqtLCYihFMf0akWWqt/ElKqdiRX
	UdCOwuJOF1xGjiCQBQk/wEGZAZFUJgGUJb5Ys5MFymsef+5UtDqpWaXTj/8BO+1qwCvJZ7
	i3eq5ufdMCbmn4TRcu/rwphc+bckoSGzK7UyLyhHwPY3BfMmgsZB8DOBAhUPlFostOZbPU
	I5N6h7PvPhpb3QRjRUGPXeuwL9ThrkA9rbBjOEJLMzkwu1bDF/WTRcvLrJurNXqV7PsqW7
	sbYDj9gGEzr6ubZzCLsUDPPWrFWVQ/Egb0ragZ4fur8vhnXAK8w/ZJ+ILBcK2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766101465;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vyZX7pvFq661JHgUNfA93rfIGVzjF+QdIzBXTL+r/k=;
	b=I6iL4Vwuc2jMlW6ya0lII1Nrc8t3ZiXD2cWywVYuhcqOKj/ogKH3UBqKnuKdcwpgC+DIPP
	JSjkwHhACmqJ6vBg==
From: "tip-bot2 for Greg Kroah-Hartman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqdomain: Fix up const problem in irq_domain_set_name()
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <2025121731-facing-unhitched-63ae@gregkh>
References: <2025121731-facing-unhitched-63ae@gregkh>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176610146385.510.2004806637905660684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     90876d9b37a0db170d5998c6c903eab2d56fd7cb
Gitweb:        https://git.kernel.org/tip/90876d9b37a0db170d5998c6c903eab2d56=
fd7cb
Author:        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
AuthorDate:    Wed, 17 Dec 2025 13:46:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 19 Dec 2025 00:39:39 +01:00

irqdomain: Fix up const problem in irq_domain_set_name()

In irq_domain_set_name() a const pointer is passed in, and then the
const is "lost" when container_of() is called.  Fix this up by properly
preserving the const pointer attribute when container_of() is used to
enforce the fact that this pointer should not have anything at it
changed.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/2025121731-facing-unhitched-63ae@gregkh
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 2652c4c..094e891 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -187,7 +187,7 @@ static int irq_domain_set_name(struct irq_domain *domain,=
 const struct irq_domai
 	const struct fwnode_handle *fwnode =3D info->fwnode;
=20
 	if (is_fwnode_irqchip(fwnode)) {
-		struct irqchip_fwid *fwid =3D container_of(fwnode, struct irqchip_fwid, fw=
node);
+		const struct irqchip_fwid *fwid =3D container_of(fwnode, struct irqchip_fw=
id, fwnode);
=20
 		/*
 		 * The name_suffix is only intended to be used to avoid a name

