Return-Path: <linux-tip-commits+bounces-6526-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B2DB4AA80
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 311F87ABBFE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BEC31AF06;
	Tue,  9 Sep 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OhARxK4J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dLR6p5Cx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5303054F8;
	Tue,  9 Sep 2025 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413507; cv=none; b=RUbkLE/CWm7d9LIHn0YJMKyE06vFhdkPXiC+aoLUXuEqvc+eUlsxIo9/9Pk4TIZOe9bSANq9MXr+dnS0Dqg5WTEoLhfcIKaAbKmTxp96tw5XizplT7FHn08Ux0kTyEwimgTiG6CjOMA1qKVDv4Hzni7gm0zYCDAuFxuo/3detxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413507; c=relaxed/simple;
	bh=f9vJ73KdON4bSTUw2M+wy/f5LodNe/cNvD3VGJqdbuI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cImTOS8bKqvfMINRBsj77+PGv6/4co1aYcSrtSQa3CnCGJfpbXcy9asC+zGZZ4TuISmxym59VOw8hxoy7GIfH36E5V4AW9StRt7gT6HUOmyNOkSKZV1OW+Tvd72nMll6gSZ58QeInxGfU++9lsffckQHLasyB1le0dqlTaLHNdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OhARxK4J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dLR6p5Cx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 10:25:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757413503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rydmIg3gVoyDVnv+Vj+/A4YMBKmj3yIxDPZnINA2PTg=;
	b=OhARxK4JxssuF4qX8TMetPKxFEcio9NOmjQKQL6umoYMsJM/63NP1QvzhlNpmpvYdP1Vcd
	rQOXDcJ6h6ln9pwVtXJ4TH6BW2nJBM2uimt3oGwU9pay5CXbAX7KXJUd1coBImYQwJyIOJ
	Cdrvgd/0ArxPlP3QtXCCaCLc6qbVe5qq/GNub8HyRgAdwTgFDpefVWM3vEhMuGVYhbt/OU
	3ouf58vH9FwswAe4UtrRBbeDsj2q/d7mwFyilbZ9nGEPr2SQvFSJhpbfWwQyX4hd1D7q/n
	OF1NTLZL6FGqUnP/ImuRRgRBgnUh0W9a2ozwnt6Slxzx4QFeyl0lPsuSbugV4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757413503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rydmIg3gVoyDVnv+Vj+/A4YMBKmj3yIxDPZnINA2PTg=;
	b=dLR6p5Cx4gWz9h7y9428IT2pTGE1JVhWGYQWMSil9s0KykyFTcrSFl0wWvISVi3Ov9bMS4
	GTfyQLL5zVjdjPCw==
From: "tip-bot2 for Ryan Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] dt-bindings: mfd: aspeed: Add AST2700 SCU compatibles
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Rob Herring (Arm)" <robh@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250908011812.1033858-3-ryan_chen@aspeedtech.com>
References: <20250908011812.1033858-3-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741350263.1920.6822636768778266103.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     23fc2a41a2c67d622d242b670a10ce8f76a7b68e
Gitweb:        https://git.kernel.org/tip/23fc2a41a2c67d622d242b670a10ce8f76a=
7b68e
Author:        Ryan Chen <ryan_chen@aspeedtech.com>
AuthorDate:    Mon, 08 Sep 2025 09:18:10 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 12:23:28 +02:00

dt-bindings: mfd: aspeed: Add AST2700 SCU compatibles

Add SCU interrupt controller compatible strings for the AST2700 SoC:
scu-ic0 to 3. This extends the MFD binding to support AST2700-based
platforms.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/all/20250908011812.1033858-3-ryan_chen@aspeedte=
ch.com

---
 Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/=
Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index 5eccd10..67be6d0 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -75,6 +75,10 @@ patternProperties:
             - aspeed,ast2500-scu-ic
             - aspeed,ast2600-scu-ic0
             - aspeed,ast2600-scu-ic1
+            - aspeed,ast2700-scu-ic0
+            - aspeed,ast2700-scu-ic1
+            - aspeed,ast2700-scu-ic2
+            - aspeed,ast2700-scu-ic3
=20
   '^silicon-id@[0-9a-f]+$':
     description: Unique hardware silicon identifiers within the SoC

