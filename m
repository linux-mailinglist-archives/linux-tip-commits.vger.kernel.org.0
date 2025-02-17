Return-Path: <linux-tip-commits+bounces-3382-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A124A37D7E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Feb 2025 09:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF203A90A0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Feb 2025 08:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DA11A5B9D;
	Mon, 17 Feb 2025 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y6VbQeQX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X1GBmRjl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D71A239A;
	Mon, 17 Feb 2025 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782320; cv=none; b=ePpnnz9vA5x8y38d404iiTZ2ca7H4n4zpkOws8agrtSLG2wUH8HuiwmFsPzSDY6M74xy2nePy4DhPP6asee5wiFyZwBREAT4OnmfxDxYVkFdOocUIsRWgxcdmTrrefzfS1vKo4CuEWgbfXn6cyLm2kV9YzyuryUfES1IEUK4NRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782320; c=relaxed/simple;
	bh=CyjIe7k3+IMbCFL/LQQGLBD6rDen/ScY64+w54jewVo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EYsZCK3w9IZXn+zl2gYPhDdravD3idZYOza/9sxJh03g856r+No20prDp42/AZwgU2Luw/4RI8lpbgz99EQy4Vebvygrvv2lzH5HnxcQHjgJUhm33dGZE/eMWzuWwGE8ViwYb/njCXHtNReuTGYuaRXgaXJEK4ahONy9rz/Bb8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y6VbQeQX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X1GBmRjl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Feb 2025 08:51:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739782316;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjgnbjAxTQ6rHkQ2QmkC3TfqKV2NrHediErt5xaQ6n0=;
	b=Y6VbQeQXtxcsS07NrA0/zcWhrVLyBxcU2qzGtpOYaX76gmST/miH6HPSY3WqDuTDoumxPJ
	KWnX1z0T12cu4qmSfVyP9elnvJ5mSWqEwv+OymdTe88v6tH22+MgXTZQE0pJ1gJFZe9F2n
	9RZoX4mJ721yPv5GHO/HI0+fKdJEPMHnywfAchdA6UkuC9grsUWkv8SCkyezaIXFy1cY1R
	Ww7Gx40fXurUsRsZM8LZISGmCx7DyqKTWCnpXHQTVExZ9mw4+Qdnbg/cgnBkMXUhl8LH+P
	StZ++Yy+7U+ZxjmYMHRSYQjIFsip/FHES7sOOsz5IwvKEI0wyoVtYeCMHR83Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739782316;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjgnbjAxTQ6rHkQ2QmkC3TfqKV2NrHediErt5xaQ6n0=;
	b=X1GBmRjlRMJ6CC6/OCpusZMxbIb9P7/78gPOfO1e0t+LK6FPUKqJ+LRvg/wZA36pqpMPLE
	WOz3PeZRIPy2h1Bg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Remove ugly linebreak in
 __verify_patch_section() signature
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250211163648.30531-2-bp@kernel.org>
References: <20250211163648.30531-2-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173978231585.10177.3897050426518699504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     7103f0589ac220eac3d2b1e8411494b31b883d06
Gitweb:        https://git.kernel.org/tip/7103f0589ac220eac3d2b1e8411494b31b883d06
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 23 Jan 2025 13:14:34 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Feb 2025 09:42:13 +01:00

x86/microcode/AMD: Remove ugly linebreak in __verify_patch_section() signature

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20250211163648.30531-2-bp@kernel.org
---
 arch/x86/kernel/cpu/microcode/amd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a5dac7f..4a62625 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -246,8 +246,7 @@ static bool verify_equivalence_table(const u8 *buf, size_t buf_size)
  * On success, @sh_psize returns the patch size according to the section header,
  * to the caller.
  */
-static bool
-__verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize)
+static bool __verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize)
 {
 	u32 p_type, p_size;
 	const u32 *hdr;

