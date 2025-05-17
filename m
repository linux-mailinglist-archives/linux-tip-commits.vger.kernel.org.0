Return-Path: <linux-tip-commits+bounces-5666-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64325ABAA23
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 15:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB49189DDB4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 13:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39595202C26;
	Sat, 17 May 2025 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WAjoNKoA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PyQpL8aB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6EB20013A;
	Sat, 17 May 2025 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747486844; cv=none; b=PHC5ODKLFOd5uuXwXY1edleoYJprzR1jCFOOvkBp1Fjkfn2Ap1GBNuPcdP8cxtcG/2m/hZUjJrozUZkoqj9Xwtx4AuSxwlr3X07Nt+Z2LuyxsGXfghkXOBphYuRQssIRZrWvGjgGhimoid9IJ/+r4PlC0+CwiVJbZcUU+vN+Flw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747486844; c=relaxed/simple;
	bh=SuS5rucRacGAxP1zF92YIdaUZ67bsk9sQcMaUgG/03o=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=paHQidPBd7zJY9S9+n+TADSrAeIVOzInasbvgY/dGmHwtoUlCkrkDjehC4cQiGbU3uqcSSvi3ZbUbi+7M6wRtCacyso0pX7g7PFlgv6LUfYSOon1p5Q/lkkDAcSacs7WvFo7Z3WmCFFWyhUl47o3+u76MEoLBBd5FJpzH2tx2GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WAjoNKoA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PyQpL8aB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 13:00:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747486840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JT8dlVEx70hveDY8hATXHkSPquU2j6k3z0L2hEV4bLo=;
	b=WAjoNKoAwkky5p2OD8UsjXbrbn6R3HBmOs5OW1aG8ixiWJgDUVEveKUp6yRugcqEcdYK9D
	cBA3OG1nFdxqSVCoo8H3FXI9wrk3jHCdbgGw92z30rp49WWqqiZ4koCm6oSNWVyFxzSeAG
	gV1zU+xr7YmYl4RZp3CX32LfTdBNmIjS8+MBN2ns4wHPMYpxycWUst1/GN8ZTGVP4WgBXD
	jevXRDRmnEKvFO2qFWqwK2BMXo6D8ViZ68JS0r4gClb29+Gdxn5zR90+IKH/ejEmlc5tA7
	hDmYgnotKhcbhuclL6X23sb7t3GMQ02Pbz83ZyRGuaXu5VRQVZ+OEP6paae1SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747486840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JT8dlVEx70hveDY8hATXHkSPquU2j6k3z0L2hEV4bLo=;
	b=PyQpL8aBmSkWSashLk6yFlsepJLNCnTaXVU40nrzH2ZbPUwkqYGSO8X4LU7Up2nOMViJjz
	r+cdBuK685Np1AAg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/bugs: Fix indentation due to ITS merge
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174748683998.406.15770168024331455064.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     a0f3fe547eb35a2dc298a78da73da73304f41ce1
Gitweb:        https://git.kernel.org/tip/a0f3fe547eb35a2dc298a78da73da73304f41ce1
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 16 May 2025 16:31:38 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 17 May 2025 10:33:32 +02:00

x86/bugs: Fix indentation due to ITS merge

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index dd8b50b..d1a03ff 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2975,10 +2975,10 @@ static void __init srso_apply_mitigation(void)
 
 		if (boot_cpu_data.x86 == 0x19) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
-				set_return_thunk(srso_alias_return_thunk);
+			set_return_thunk(srso_alias_return_thunk);
 		} else {
 			setup_force_cpu_cap(X86_FEATURE_SRSO);
-				set_return_thunk(srso_return_thunk);
+			set_return_thunk(srso_return_thunk);
 		}
 		break;
 	case SRSO_MITIGATION_IBPB:

