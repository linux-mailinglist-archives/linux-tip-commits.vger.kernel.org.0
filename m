Return-Path: <linux-tip-commits+bounces-7343-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2640C5D275
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 13:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A027D4E791F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 12:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57BE1D8E1A;
	Fri, 14 Nov 2025 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1kLwXs3S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2h9MGGMV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2679E1D5CD9;
	Fri, 14 Nov 2025 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763123788; cv=none; b=XqAiJfBrq7SHE3APnll6po3C0/4kDXserqPTYv888pLDocs7JJJSA/F3bhlE5GS3R+/ixhO/9rfqYJBLIalp9fxOIG/PxsUrRt2My2nMhAOHjCpyTlsuSQjXp6quq8yAbx0jy5iBUrIk5TxxBpnfDBBluuQ0Lwys9BVnJexNjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763123788; c=relaxed/simple;
	bh=OsOU+l0gFPofg6u8A1ySFI9FSsYND8nnwIcXkTqKdWM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=McYoO/7tk/O75Orgd9oLwzDvXlrysdXRG50opwpto5b41BULxRxTbTF9VBe4ELGS7VRHEgIEfbs4FKTEJD3jHZEL0LIiIsQYMlQCQPIVjsyMTKbSjn6CWhfejNs3TleakiInF7yB4xw0KaKObbNgrkJ36xZuOQfi/v18PJCRMuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1kLwXs3S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2h9MGGMV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 12:36:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763123785;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYwR9EfEiQuMxq8nHLgt/sR2PwtZRqTThKUMPdkjwOs=;
	b=1kLwXs3SXiBj1z8KdzZnik8clkQA2hZVPaT3qFwJO/jauX0LT3dflGlKoZeC5kpzct0gmV
	Z40K8dABqF4sqUkKMTf1vkEa/eJwxo+w8ltSi+hfLBLznxEDeK5/RxlSmUSGIQRvXMDYUZ
	q0PvLZpjUYAWhXbkHIaOAoOS7abiiEXa+lFYlF4z/sI+EvvcAlgFbuU7+FDhIXuDDT+YqT
	7wNaJ9RPhYqAi+zaB5FmKk2n2JFaTzRUhUkZ4fehcZnNoof9iGj+kQFq04Ca0/9zKyGr0c
	pucjBw9jxL83fn1/VzSgRAMc9LnbSNLt4rT3vhZvDp0Egd4iu5ordCC5/hMhOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763123785;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYwR9EfEiQuMxq8nHLgt/sR2PwtZRqTThKUMPdkjwOs=;
	b=2h9MGGMVgvWoMcmSNmdl0421gBfrX5MLXBiFywyWrixzYuxsmroEUN0fBcJSuM6xK+cHKY
	Yu6iZKNFPqXefxBA==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Add additional fixed RDSEED microcode
 revisions
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,  <stable@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251113223608.1495655-1-mario.limonciello@amd.com>
References: <20251113223608.1495655-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176312378412.498.16967122427223509290.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e1a97a627cd01d73fac5dd054d8f3de601ef2781
Gitweb:        https://git.kernel.org/tip/e1a97a627cd01d73fac5dd054d8f3de601e=
f2781
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Thu, 13 Nov 2025 16:35:50 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 14 Nov 2025 13:02:11 +01:00

x86/CPU/AMD: Add additional fixed RDSEED microcode revisions

Microcode that resolves the RDSEED failure (SB-7055 [1]) has been released for
additional Zen5 models to linux-firmware [2]. Update the zen5_rdseed_microcode
array to cover these new models.

Fixes: 607b9fb2ce24 ("x86/CPU/AMD: Add RDSEED fix for Zen5")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://www.amd.com/en/resources/product-security/bulletin/amd-sb-7055.=
html [1]
Link: https://gitlab.com/kernel-firmware/linux-firmware/-/commit/6167e5566900=
cf236f7a69704e8f4c441bc7212a [2]
Link: https://patch.msgid.link/20251113223608.1495655-1-mario.limonciello@amd=
.com
---
 arch/x86/kernel/cpu/amd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2ba9f2d..5d46709 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1037,7 +1037,14 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
=20
 static const struct x86_cpu_id zen5_rdseed_microcode[] =3D {
 	ZEN_MODEL_STEP_UCODE(0x1a, 0x02, 0x1, 0x0b00215a),
+	ZEN_MODEL_STEP_UCODE(0x1a, 0x08, 0x1, 0x0b008121),
 	ZEN_MODEL_STEP_UCODE(0x1a, 0x11, 0x0, 0x0b101054),
+	ZEN_MODEL_STEP_UCODE(0x1a, 0x24, 0x0, 0x0b204037),
+	ZEN_MODEL_STEP_UCODE(0x1a, 0x44, 0x0, 0x0b404035),
+	ZEN_MODEL_STEP_UCODE(0x1a, 0x44, 0x1, 0x0b404108),
+	ZEN_MODEL_STEP_UCODE(0x1a, 0x60, 0x0, 0x0b600037),
+	ZEN_MODEL_STEP_UCODE(0x1a, 0x68, 0x0, 0x0b608038),
+	ZEN_MODEL_STEP_UCODE(0x1a, 0x70, 0x0, 0x0b700037),
 	{},
 };
=20

