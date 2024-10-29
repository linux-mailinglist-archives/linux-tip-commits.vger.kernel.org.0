Return-Path: <linux-tip-commits+bounces-2645-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FEE9B5113
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 18:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDFC2284087
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 17:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0A0200C98;
	Tue, 29 Oct 2024 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KhmMCzFy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="coPdOObM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662BE1DB943;
	Tue, 29 Oct 2024 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730223358; cv=none; b=us82zoYQs1vxFkNQTQKOIVH9zbGCT45aqEfTJY5gfJ4cN0jydPdLMIwwzRUGC56jXInI2R6/50IBWd/+1a5YOXGWvPR4pGdpVZNf9aWL4ECQ0yEr8TaVU6v5IBzggXc4zYea+xti97T2mV1sCxQC429HHJ0g4HBPP7JZ0TKnTRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730223358; c=relaxed/simple;
	bh=LuVBK53BP7iaQuv2vNNnGPEqgoR+TEkqLXVrY5+1E8E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m6YXxpONfpQCwzBns9l2yLip0i2Tmt2CpSl033QUzSBVEwiB/egqq1h7t5HLa1YPy5dMtuUjaDRLbrmySN8uFGA7FoNRg1XI3FzyB89u/yYjsQl+QZ5pwjO600Ra8xFTw2W0M3B23ZJQ3OgwHSIRI9UNKG+nTmejNIhWmQ9ssgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KhmMCzFy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=coPdOObM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 17:35:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730223353;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skBvmer5JZ8LK0xj40epDesXhercBzPabx0m54D7WFU=;
	b=KhmMCzFy0+fr6TXG9rwPeRWIZh/2A3c6dXcCDeTSjXvM4uM3r5KSnWFdPNXz5M0L5HAqxm
	g6quB/s4iaCuyl+pZqLxL6+uU8oPjbsHYMBEQymQJJp5qg+TeE4rVqv7loYnqgGo82IX80
	RePVTUobilGXUnj2njAbAbsRv0fX1jhB6KEKk/F+wxkFtK4cqu7d6YW50P8wLsh4usnpRZ
	2Vf2cHPycAmLjMiFuvJVq79niG4J7R4HJo37s9veX+5RBasFtDaLCPNatALRB0Qxrg4s5o
	1LhMFwYrY7vEbc3by8n80vBp/V/4+Y3XUP+mw2XfN5k2fFRmIaxMge+PhK9W4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730223353;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skBvmer5JZ8LK0xj40epDesXhercBzPabx0m54D7WFU=;
	b=coPdOObMoVEGFmO4VhJy5un9Gc9KKC2q4B9XwOEnEUjpoubjssEBerkFn5uBMBayMB3TBw
	jthiDzH+Q88CZVBg==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB
Cc: Arnd Bergmann <arnd@arndb.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 ilpo.jarvinen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241029092329.3857004-1-arnd@kernel.org>
References: <20241029092329.3857004-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173022335245.3137.8617281185913010359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     fce9642c765a18abd1db0339a7d832c29b68456a
Gitweb:        https://git.kernel.org/tip/fce9642c765a18abd1db0339a7d832c29b6=
8456a
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 29 Oct 2024 09:23:20=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 29 Oct 2024 18:16:05 +01:00

x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB

node_to_amd_nb() is defined to NULL in non-AMD configs:

  drivers/platform/x86/amd/hsmp/plat.c: In function 'init_platform_device':
  drivers/platform/x86/amd/hsmp/plat.c:165:68: error: dereferencing 'void *' =
pointer [-Werror]
    165 |                 sock->root                      =3D node_to_amd_nb(=
i)->root;
        |                                                                    =
^~
  drivers/platform/x86/amd/hsmp/plat.c:165:68: error: request for member 'roo=
t' in something not a structure or union

Users of the interface who also allow COMPILE_TEST will cause the above build
error so provide an inline stub to fix that.

  [ bp: Massage commit message. ]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20241029092329.3857004-1-arnd@kernel.org
---
 arch/x86/include/asm/amd_nb.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 6f3b6ae..d0caac2 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -116,7 +116,10 @@ static inline bool amd_gart_present(void)
=20
 #define amd_nb_num(x)		0
 #define amd_nb_has_feature(x)	false
-#define node_to_amd_nb(x)	NULL
+static inline struct amd_northbridge *node_to_amd_nb(int node)
+{
+	return NULL;
+}
 #define amd_gart_present(x)	false
=20
 #endif

