Return-Path: <linux-tip-commits+bounces-4984-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE46BA889FF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 19:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74ED1899777
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 17:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB4A28B4E0;
	Mon, 14 Apr 2025 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L30lONDw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sl5TRMJ/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7951128A1D0;
	Mon, 14 Apr 2025 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652387; cv=none; b=CyNnotfDiFqEyQHk0zBAPee6MOTEfxczWnGWo42uyObN4EvzyE8hzoLhWIc6NU5lTaURdqtotUWNvBnNlOaFZSJrxCSf6luifov6OvyaTBjphYs7en24QzWebo7xzXNftzrA8My5EUMv8RO726pxtxN8NfAXf33IAo1xK7CTMC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652387; c=relaxed/simple;
	bh=L+YG9CcZWItojjcA9gu308EVx+7X0qTbclCSdwqoVZU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QXRQhpoLmhoJJIdsKT5oK+1F+O8g3KFMix9HBAgoc3h4VxwKMJKMLzmloMG4pjfQbVhMnQT+bkFzRch8PTxH/kBHGar9pLPR+8QxppUUlf/ERqzZOxnj6MjNqj1W2GZm/qsPgm+Dfg7/lFjdgYGCKjrMhQi8LiIbfS+YJFzKiQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L30lONDw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sl5TRMJ/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 17:39:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744652383;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mr0UEvmsbJlOwmijiT1ZDwoAtDK8w3C5a4c9bXdwi5c=;
	b=L30lONDwI2hXPOa/HZLpQiNSncz95oYsVykjnyOw0FaCJJplTdhVzPTr34X4rzBDqq2+CL
	tJdlUBZ1NLDwCa8bRb1hG9Mu4xfmGIjlB6YRbdc5oz2lXJtYcox1GSHDk1scDWsogdn1cb
	fpB0uRDBt0hgoNSq79CSPHX/jQYvX6kal4j+tRfb5gp3TVrMHB7eFF+cyx9qFS3poDmN1A
	W3Gepyl8GwgR+MVy2qKzdQKJKeT2nsAK2YPuxP3oRU8q+8+mvRPcVFAurr6S7tcI4ZTPHC
	xE0y8S+yWNK50gBJDj60CGogOLT1HzVAEMTAUkmBX7NAX/l0AptY0ValCpsW1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744652383;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mr0UEvmsbJlOwmijiT1ZDwoAtDK8w3C5a4c9bXdwi5c=;
	b=Sl5TRMJ/cCLmdVs7Hqp9WkAZzRPG4yvDnZa0XvDngDMbzUb/f2jlVYdtxn0UR8ChsIG63Z
	o5fSmE0jNrLUufDg==
From: "tip-bot2 for Inochi Amaoto" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] dt-bindings: interrupt-controller: Add Sophgo
 SG2044 MSI controller
Cc: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Chen Wang <wangchen20@iscas.ac.cn>, Chen Wang <unicorn_wang@outlook.com>,
 Conor Dooley <conor.dooley@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250413224922.69719-2-inochiama@gmail.com>
References: <20250413224922.69719-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174465238292.31282.3635137520292392856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     9fe5a0790af6af619940a2819aabe8f6fb30700c
Gitweb:        https://git.kernel.org/tip/9fe5a0790af6af619940a2819aabe8f6fb30700c
Author:        Inochi Amaoto <inochiama@gmail.com>
AuthorDate:    Mon, 14 Apr 2025 06:49:12 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 14 Apr 2025 19:35:36 +02:00

dt-bindings: interrupt-controller: Add Sophgo SG2044 MSI controller

Like SG2042, SG2044 also uses an external MSI controller to provide
MSI interrupt for PCIe controllers. The difference between these
two MSI controllers are:

  1. SG2044 acks the interrupt by writing 0, SG2042 by setting the
     bit related to the interrupt.

  2. SG2044 uses interrupt number modulo 32 as MSI message data, but
     SG2042 uses the bit related to the interrupt.

Add support for the SG2044 MSI controller.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Chen Wang <wangchen20@iscas.ac.cn> # SG2042
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/all/20250413224922.69719-2-inochiama@gmail.com

---
 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
index e1ffd55..f6b8b1d 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
@@ -18,7 +18,9 @@ allOf:
 
 properties:
   compatible:
-    const: sophgo,sg2042-msi
+    enum:
+      - sophgo,sg2042-msi
+      - sophgo,sg2044-msi
 
   reg:
     items:

