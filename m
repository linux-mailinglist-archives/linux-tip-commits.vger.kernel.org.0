Return-Path: <linux-tip-commits+bounces-7102-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911E2C1F98F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 30 Oct 2025 11:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDCF3B8FA8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 30 Oct 2025 10:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD81351FAF;
	Thu, 30 Oct 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aBX0RDbW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v6Mgd5hs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F82341648;
	Thu, 30 Oct 2025 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820621; cv=none; b=lq/9qAIySp0P6fZ7vNj4FE2qMzq4KVE/iJqF2Ju/BACROWCWo8rPbTIMFWCQCEGpbnRyfjDQBIc43tcHfqhZ/mfNcl3osQzyfUNBbM8hqeNP/fiIb51cLViJ3Z0DGCV3J9WHDB/pq9UVmfV92b4j9DSHLlEv7nrHYSPfrqKABPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820621; c=relaxed/simple;
	bh=L8b13vfr/o8PIDJQEKUPohIMgSikN01SUV6G6Aj6AGs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iKwmYbfdAPmFYyDPSUIBLmBdn+Bw3X9wtO90pdnQ536MJgs363Izapq5soyX83fz3229s2619IzbIM6xhEXkEwH2rNlb1T7VXr/wiyR5aLhSy82OQrpEF09Q9x+cc2X4ewaUgEfqeYfuYSRmzolLAHQnwJKTr1y0U2XypEpfyBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aBX0RDbW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v6Mgd5hs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 30 Oct 2025 10:36:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761820617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlmTeIY1qN9QihaueXPyguFmOe8rD/j9b336BhDLo3Q=;
	b=aBX0RDbWIVHTpC6b18FqI6HkC74+4asDiE6SESEBMjlRHMHim4zjTvmG3/ntbKieuIKg1s
	C6Mr7Psqq1/TykYpWU4nHyMVVpLdkWNtgd8l/eYY/nm5Ohrz7PD+YjmSdwpKjOs1MuB7XH
	68kbNEoPKQU69bRKtLNYGtyy0TQgYuG2ALrmgi99iuXralFLVUq6hg0NfC97h/DGgJXwp3
	y0fCHjdwtQO8FNlKuufeeYLezHOqvOFb++S5OvozUEGKl9fkzVPfcekdbmT4O8F2JZ3zDW
	/bKEoXFZ+a0UWPlB2hNW3DaJuhtAES/sq7nTxQ+cOmDQ1jT/iE/Y/cBKKYDwhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761820617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlmTeIY1qN9QihaueXPyguFmOe8rD/j9b336BhDLo3Q=;
	b=v6Mgd5hsmERvLWHK+ftwWeYDoDGqVgriCgNhH/TbpJyyU9O4FUyW5p4eDcjgk9fh+AtsDH
	s3b4isLv1ZiEM1CA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Extend Zen6 model range
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251029123056.19987-1-bp@kernel.org>
References: <20251029123056.19987-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176182061649.2601451.8878178575772709358.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     847ebc4476714f81d7dea73e5ea69448d7fe9d3a
Gitweb:        https://git.kernel.org/tip/847ebc4476714f81d7dea73e5ea69448d7f=
e9d3a
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 29 Oct 2025 12:34:31 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Oct 2025 11:33:55 +01:00

x86/CPU/AMD: Extend Zen6 model range

Add some more Zen6 models.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251029123056.19987-1-bp@kernel.org
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index bc29be6..8e36964 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -516,7 +516,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 			setup_force_cpu_cap(X86_FEATURE_ZEN5);
 			break;
 		case 0x50 ... 0x5f:
-		case 0x90 ... 0xaf:
+		case 0x80 ... 0xaf:
 		case 0xc0 ... 0xcf:
 			setup_force_cpu_cap(X86_FEATURE_ZEN6);
 			break;

