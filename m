Return-Path: <linux-tip-commits+bounces-7333-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2171C59750
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 19:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 401A6353A0A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F1C357A31;
	Thu, 13 Nov 2025 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wN1DghAw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NIRsm0+8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2869264614;
	Thu, 13 Nov 2025 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058421; cv=none; b=WENkd9TQtCHm9VJd3XbmqejmZUud4jXYW6KZ8++KCoUVY3V6mbr2oetzkN1IWt9lpC/K1n2NI7njik/CS/yr4QOIMLo9qJvxXI0/bArXKksgIRS+9dSY2qpH7+jlMabs+M3xC8ZTlVyXi7Qvg5KrQyqcqMq8KBampanmY/hOd9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058421; c=relaxed/simple;
	bh=y5/cD0dSrkdxfAzSfApzUYSi5PRyhdfVJU6JI2BEmvA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=OCvd5DGO2pG2RAEX8yZiq3xgJGZ3tPtewnninjyh4BwMcNa2Jd3ufGr7CpGPkWKRrLlATUJaOUZRemCI/rEeW0qq4TXZkOMHTsEdyPhVNR7qA+ULsW+r8a/TxdooOKw5cDx7uEP/6cjb0LAm87xPZusElz+yIcvzUOxpTZgHqO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wN1DghAw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NIRsm0+8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Nov 2025 18:26:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763058417;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DBEoeguPNQcfGtvlsbgvjkOgpfr7l+//uXze2WD0V8w=;
	b=wN1DghAwdgUxd9vqNhPPzc0niDs7WL1T5HQiLuJOY7Ju4vtzJysLx03wfWwlB6IjpsJc1S
	ZER+YmOuHNuJVWBH5jhB8RLSIz8RQt+PZJo2FNPpZePJqW+QwRR6Ao3WeT0xjV5a58//BN
	mGZ1SiVU6eQvubn+7JabSdXCigfRvFZUATFOfTI5lWRSmKEXwBbsU6V8ETKY2pgcz3ekFq
	1DoFt0UbUDNdOuORVuUuwJgUsTWI7UUxl2u7DCm6Yg2vp6+bx6+HwTETZmUuSuEL+s+oDq
	Dh7qJaXOfijBAfcwPn5tbpe0yYi4ws6EogQ4QIOHX6RDB/H4n9JFO+NrgNjgBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763058417;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DBEoeguPNQcfGtvlsbgvjkOgpfr7l+//uXze2WD0V8w=;
	b=NIRsm0+8WabZnqCfc8gWeGU7qjZSaUxTwv9fEAle74xDerI0xp5/QuRwfgaWLP078KRJxS
	ATTjGwG6naNmZZDA==
From: "tip-bot2 for Kiryl Shutsemau" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] MAINTAINERS: Update name spelling
Cc: Kiryl Shutsemau <kas@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176305841645.498.15923969535832705130.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0a8fb03fe7b0abab0ff16522e2625163183e7ae4
Gitweb:        https://git.kernel.org/tip/0a8fb03fe7b0abab0ff16522e2625163183=
e7ae4
Author:        Kiryl Shutsemau <kas@kernel.org>
AuthorDate:    Thu, 13 Nov 2025 12:10:06=20
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 13 Nov 2025 07:58:47 -08:00

MAINTAINERS: Update name spelling

Use transliteration from the Belarusian language instead of Russian.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251113121006.651992-1-kas%40kernel.org
---
 .mailmap    | 2 +-
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 369cfe4..0f74e16 100644
--- a/.mailmap
+++ b/.mailmap
@@ -426,7 +426,7 @@ Kenneth W Chen <kenneth.w.chen@intel.com>
 Kenneth Westfield <quic_kwestfie@quicinc.com> <kwestfie@codeaurora.org>
 Kiran Gunda <quic_kgunda@quicinc.com> <kgunda@codeaurora.org>
 Kirill Tkhai <tkhai@ya.ru> <ktkhai@virtuozzo.com>
-Kirill A. Shutemov <kas@kernel.org> <kirill.shutemov@linux.intel.com>
+Kiryl Shutsemau <kas@kernel.org> <kirill.shutemov@linux.intel.com>
 Kishon Vijay Abraham I <kishon@kernel.org> <kishon@ti.com>
 Konrad Dybcio <konradybcio@kernel.org> <konrad.dybcio@linaro.org>
 Konrad Dybcio <konradybcio@kernel.org> <konrad.dybcio@somainline.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 46bd8e0..ffd964b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27845,7 +27845,7 @@ F:	arch/x86/kernel/stacktrace.c
 F:	arch/x86/kernel/unwind_*.c
=20
 X86 TRUST DOMAIN EXTENSIONS (TDX)
-M:	Kirill A. Shutemov <kas@kernel.org>
+M:	Kiryl Shutsemau <kas@kernel.org>
 R:	Dave Hansen <dave.hansen@linux.intel.com>
 R:	Rick Edgecombe <rick.p.edgecombe@intel.com>
 L:	x86@kernel.org

