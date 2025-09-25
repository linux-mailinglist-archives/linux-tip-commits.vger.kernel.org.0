Return-Path: <linux-tip-commits+bounces-6758-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960D3BA19C9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA28A7B6309
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3AB32E2D6;
	Thu, 25 Sep 2025 21:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0YvftlgF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="It96fcQl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6C32D5B6;
	Thu, 25 Sep 2025 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836024; cv=none; b=lDDWbncKrblx5oet+FTjpGC/EHpd2Q0k9yQoi10qDIohS/krkpb/JFCfggIdKGSoNwYjlQumKhkPRuRANbAYq2IUEYaJlLj99eI2vtE105iqzZZgokhz0A5TjAHBgDClROXKqMqQFV2HIbbkx2GfM497kfCeuct3rZdrAVRFOt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836024; c=relaxed/simple;
	bh=+e8Q9fIqjGb71hBpcJlcCptT6WmRtZgwoLj9qHirNQU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=jKZbVDTtTmjX8McjTqeUstjXiU7t8nYqfm6/8W6G6f+jVJSG/V5iv1VGtZUWBnH++eXuCEurxtb3BGpb36D7YNXUxyinMCFKgjePXsGPGK7yxPEodOl2/Jny1EIi6V47zankr7545JwsuDObtrRN/JOEuNM7ZijkesBubaXxWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0YvftlgF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=It96fcQl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qpWmSX3Js1lQ2ye6uggYhzyRBbxTsttVsDH+YFosRsw=;
	b=0YvftlgFMik/KoYE225xHnmOgKL95PAovCrD4DqgedTx5uxnzjNx8+C+6SJ6TqYM904B3v
	WCKQ78lgF1QVfm24LIkN7ZYR5aWr7083toz+H0IcD9oi19z/1lHjSOP0gUq6hMZHr7ejP4
	wcVjdPosIV3tRIJXB9+YpxOQGHznPwpRr4LHVmUQc2PX401qhfY0csHdnNJtnpeVN6u9D7
	CtX/oWFTlIn+HPwzexHHBmWMdn3+Qdyb6s8c7Y0kTxXA9Ixk2UlabJbugmB1nC9/gSrjAX
	HatseUVOgDgE0G8SBFpaRzrbi/tnlBgh3j8jQI8kVRGLfdd/ymK+d79r3V1/6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qpWmSX3Js1lQ2ye6uggYhzyRBbxTsttVsDH+YFosRsw=;
	b=It96fcQldGE+S6xNFpCUu4bPhwVcX/J46qGYAvhHXmbyOeaFVTG/RqwKW4SRwrZG+iao3c
	Ia5BQQablEAGvaDQ==
From: "tip-bot2 for AngeloGioacchino Del Regno" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: mediatek,timer: Add
 MediaTek MT8196 compatible
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, nfraprado@collabora.com,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883602039.709179.333245204374664019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     99d19715daf5553a28452a4ef95e9692277e2787
Gitweb:        https://git.kernel.org/tip/99d19715daf5553a28452a4ef95e9692277=
e2787
Author:        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
AuthorDate:    Wed, 11 Jun 2025 13:07:58 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:56:29 +02:00

dt-bindings: timer: mediatek,timer: Add MediaTek MT8196 compatible

Add a new compatible for the MediaTek MT8196 SoC, fully compatible
with MT6765.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250611110800.458164-2-angelogioacchino.delr=
egno@collabora.com
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

