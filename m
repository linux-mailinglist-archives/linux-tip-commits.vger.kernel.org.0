Return-Path: <linux-tip-commits+bounces-6164-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991E1B0EB97
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD72F3B0C87
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A20A272E42;
	Wed, 23 Jul 2025 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qsxvMFPu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hOiFqGdH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726725A659;
	Wed, 23 Jul 2025 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255042; cv=none; b=KuWWW01yy5RZTKEpMGOy0UbRK9WaIOFQH8DO9/Pw13e17d9MpQHIEs/SjouCdwrIvY65dWZOIbmim3F3UtclMPW5OqJrHPXYQ1Ac08U31op1G9KBiX1jXIGtzuLpyAMsiXtbuS/BvJviLSLzQl8fglt+SGVUPP7CfKjubH0QOQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255042; c=relaxed/simple;
	bh=k8Oek8S4CX+33L1JFVtSwo6s0o5WOxgou8lPu9+cHgU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tCEL8tkObv+jOcZcgyP0rUMi+nFPqjHgDkzUb9RIlgbcxxpYa71zsh/DIdRqsVPygiDzHq4K6jQiLDhLOuEepWGy9o6Z6b23C6sg2UYKvWynxxEmFxOvoVZVNsm+MNrAzlf9GrMN+bjSC+nOuGh0PN82G12/60LGy2UZXo3eYHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qsxvMFPu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hOiFqGdH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EjpZFY5IT2o8h/dvQ7mRONiVbgOpC1miUG0ZWCut7u4=;
	b=qsxvMFPuxobt1ZOiDm4rpkJko3r8gvFy14f6iQJLVG/HQXFVm1MjmQTPPW7fTYpQIbs+r0
	a3cg0ieQM6+eUNHc6tUHBsGA3d6YCLUaaT3LLe4rkC3Sqkvn0R2W5P84Enp8JpmTJxeqHs
	idUc4hwP7F9b8TQ0tLdcRnJ8r/H20fmWvmYio/dz9yoQIpYR3D23doe7Gb2F6dlzkF4d72
	Cv9HQl4b2Z8l0zCE96cwr+igx/IJu1giWUKm24Tdpjz6lY+guc6KbPp2e97OCDf4wC0gPa
	m2XONJXdIBIRHazvF+yTs7jW5zwtbdjHkj3TrHn7I3F8GmkrfIsPeaZd6GrAeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EjpZFY5IT2o8h/dvQ7mRONiVbgOpC1miUG0ZWCut7u4=;
	b=hOiFqGdH8/e1m9GleobdtGD4uJcs/V99tmWKzLKS+s0bWpmh80gxVNxzX/xh2Qqvrq+JTN
	wSdGvkgbCWLcj/Ag==
From: "tip-bot2 for AngeloGioacchino Del Regno" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: mediatek,timer: Add
 MediaTek MT8196 compatible
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Rob Herring (Arm)" <robh@kernel.org>, nfraprado@collabora.com,
 Conor Dooley <conor.dooley@microchip.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250611110800.458164-2-angelogioacchino.delregno@collabora.com>
References: <20250611110800.458164-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325503810.1420.7272588571924460318.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     787db68389ccd119ce4641e6b5d612584f1de430
Gitweb:        https://git.kernel.org/tip/787db68389ccd119ce4641e6b5d612584f1=
de430
Author:        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
AuthorDate:    Wed, 11 Jun 2025 13:07:58 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Jul 2025 13:30:57 +02:00

dt-bindings: timer: mediatek,timer: Add MediaTek MT8196 compatible

Add a new compatible for the MediaTek MT8196 SoC, fully compatible
with MT6765.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250611110800.458164-2-angelogioacchino.delr=
egno@collabora.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/mediatek,timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml b/Do=
cumentation/devicetree/bindings/timer/mediatek,timer.yaml
index d5b574b..e3e3806 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
+++ b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
@@ -45,6 +45,7 @@ properties:
               - mediatek,mt8188-timer
               - mediatek,mt8192-timer
               - mediatek,mt8195-timer
+              - mediatek,mt8196-timer
               - mediatek,mt8365-systimer
           - const: mediatek,mt6765-timer
=20

