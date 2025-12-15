Return-Path: <linux-tip-commits+bounces-7724-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01999CC00BC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42D083035A7A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939A83314B9;
	Mon, 15 Dec 2025 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BKbHN6dD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RzgbfN5/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFC632F761;
	Mon, 15 Dec 2025 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765835231; cv=none; b=FdFRw3GfjN4wyC4gZnuTmSktOTNk3iwuGLsuIv+poaX6ifxg4T+0lMbaMgiDE9uzfNLmFild9Qrl0+xCZlgs1HPcNuxT5cCZ0YGKdWitl7Q7WEFyxy8att4f5zvHZIMQ65uVArI5ADp5JEhvDPUtL5+VNNpEi4duBUc9LbW92/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765835231; c=relaxed/simple;
	bh=YU4E/rPX1UvfxKBVh2E44Pm3Pk9Vuxfw+dLslOFfz2s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mm+QA8IzaCWNbfs1AHUODqnbwDGIj2dIpmk/fnTk4eSQGWD/Bq0Qf6EyAq7fNCjraZ/COL1GJ9IdnEPHgg9mWaYZlvOqbpCB/dsR9c7LitJdBRq7W5Y6XCLtI1Oj8ARd1KvEes8EsF0KUon7LNpHADVjGLb6dRpZ02MPuMLiX3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BKbHN6dD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RzgbfN5/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:47:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765835226;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8gm0CG5BzSgfUtqnFbxm3dZd6trrId6dJXfs5hm3c/8=;
	b=BKbHN6dDe+P5yCxng3zU6PliJ/oFgetS3+VEBwGTcsHPtnKcw6pLJVZenzvt1kmk34VmWT
	dt0PVDqFWvcjShUQxOMabsptHaSonZJp/AOSuL4uQ9mmR27ibibpfOk6rixzBjpX5fhaVN
	dgANnSf6NSJFp/Nm9jN85eqF0Q25IkPhjU+p/9dXw3C3sOIBK0t4COEC54awP3nqBP5vSo
	6evAz75uNqKV4lgWfbletexd84Br4wIM49Ad9LsWRAgd193jZJpltT7xXrXr7cmM+AQ9aP
	FzrdzcKRDrIhEPvmU5lnsOg5d2gNIzoHbikZbLeyu4B55tZMiGMekuLeA49oHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765835226;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8gm0CG5BzSgfUtqnFbxm3dZd6trrId6dJXfs5hm3c/8=;
	b=RzgbfN5/vgUb9RrPZmvBNtw7hIAFgmkHYh9xEgrtO7V73dNo5r6eLH2UeAyjP6Rnto+e1Y
	G4EEZTaBLmgXhcDw==
From: "tip-bot2 for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] dt-bindings: interrupt-controller:
 renesas,rzv2h-icu: Document RZ/V2N SoC
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Conor Dooley <conor.dooley@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251127162447.320971-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251127162447.320971-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583522499.510.12733837316421610224.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     c71869c61d7cf2070421cdcc4dd64c4c860df49d
Gitweb:        https://git.kernel.org/tip/c71869c61d7cf2070421cdcc4dd64c4c860=
df49d
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Thu, 27 Nov 2025 16:24:46=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:44:31 +01:00

dt-bindings: interrupt-controller: renesas,rzv2h-icu: Document RZ/V2N SoC

Document the Interrupt Control Unit (ICU) used on the Renesas RZ/V2N SoC.

Although the ICU closely matches the design found on the RZ/V2H(P) family,
it differs in its register layout, particularly in the reduced set of
ECCRAM related registers. These variations require a distinct compatible
string so that software can correctly match and handle the RZ/V2N
implementation.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20251127162447.320971-2-prabhakar.mahadev-lad.=
rj@bp.renesas.com
---
 Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-icu.yam=
l | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,r=
zv2h-icu.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesa=
s,rzv2h-icu.yaml
index 3f99c86..cb244b8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-ic=
u.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-ic=
u.yaml
@@ -22,6 +22,7 @@ properties:
   compatible:
     enum:
       - renesas,r9a09g047-icu # RZ/G3E
+      - renesas,r9a09g056-icu # RZ/V2N
       - renesas,r9a09g057-icu # RZ/V2H(P)
=20
   '#interrupt-cells':

