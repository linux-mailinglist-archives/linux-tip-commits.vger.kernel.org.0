Return-Path: <linux-tip-commits+bounces-6994-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F128FC07EF5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 21:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D05BE4E5EF9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 19:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CF52E6CCC;
	Fri, 24 Oct 2025 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sknq6rTP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YWfC1vl3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6982C0303;
	Fri, 24 Oct 2025 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761334775; cv=none; b=GQb3rmQ+oSmHgoyLTs9cL7L9TpPVaR4d+nkw7fnXUJs+hRQ6YE2rB9VgOCXJP1xG0NWJIB+r4OHb2uu+Ocy0W8pCCtBa9pKhZeiG0NMQ/V0C0rVlSa07sI8oJujgZLCKtjrx9Tivkk82c1DXE1NrSVc5EHqqbTSO1x7aggRMIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761334775; c=relaxed/simple;
	bh=UdZZ+eWCeij4oh6v28oKnlPFCM06z7ReHKclLiQ+UN8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W0C8INzqSuN7oKtcNqm9qMnYt2y4hREjXr1lnz7BhWqw6apYtXLHxafg9+XfMfai3M6lMp5+KLUoXQsqU1xgdA91mVkv/GzKrLmHv2pqC2n+V80hAIEIiCo3m0G8Q7obGUXqHoOHowdLsoTGOhWj4+EpbPrWoF+WP5qISO4aoWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sknq6rTP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YWfC1vl3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 19:39:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761334772;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJo/GLBJ9TFrhWdQvD9mPXyGKNZgrqDjEjx+8QGLwdM=;
	b=Sknq6rTPMLTAV6qt7ZjLNM9sX4SrFA6Q3mjRUNCmYxQEFsuXQN60Ob//nbFxhil+0uGkgu
	sMpfqnPuylpq3YSPFKxJBMVQpnXCwe9vJNEUmFGvzb4v+jzIwLbB+xLH/ouscYVqi9XKP0
	SbGTmRPj9gWr9Bii6zbPkIO9UNSHnyESH4rDjFaAIqaLkFUERs3vkkmmpYsrx4EES3lcEO
	3qvJulC3DL/85FCtsGuvVhrCZzKoOuW5QX3HC2BcPy9cL3HXScdWLoMZgcxRy4UCY0+kJv
	fY8EKS+7QXviahJ+/hb1VPj1b0HFMRQpT+0MDXtavp9vnsFYMsV4SdSa0KJ5MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761334772;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJo/GLBJ9TFrhWdQvD9mPXyGKNZgrqDjEjx+8QGLwdM=;
	b=YWfC1vl3gLHUkO3Hx1PuS7Jm8wvkzB9H2ZvnLz7UL9FKfo+gr//mUn/HaNw3nnUt1Xs+z2
	lAQ+FukJqevgNqDA==
From: "tip-bot2 for Lucas Zampieri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] dt-bindings: vendor-prefixes: Add UltraRISC
Cc: Lucas Zampieri <lzampier@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Rob Herring (Arm)" <robh@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251024083647.475239-2-lzampier@redhat.com>
References: <20251024083647.475239-2-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176133477124.2601451.13839165981997115501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     e95f66dd0e74d654e5ff344c72cfd6bd9f6c60a3
Gitweb:        https://git.kernel.org/tip/e95f66dd0e74d654e5ff344c72cfd6bd9f6=
c60a3
Author:        Lucas Zampieri <lzampier@redhat.com>
AuthorDate:    Fri, 24 Oct 2025 09:36:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Oct 2025 21:34:31 +02:00

dt-bindings: vendor-prefixes: Add UltraRISC

Add vendor prefix for UltraRISC Technology Co., Ltd.

Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20251024083647.475239-2-lzampier@redhat.com
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documen=
tation/devicetree/bindings/vendor-prefixes.yaml
index f1d1882..647746e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1705,6 +1705,8 @@ patternProperties:
     description: Universal Scientific Industrial Co., Ltd.
   "^usr,.*":
     description: U.S. Robotics Corporation
+  "^ultrarisc,.*":
+    description: UltraRISC Technology Co., Ltd.
   "^ultratronik,.*":
     description: Ultratronik GmbH
   "^utoo,.*":

