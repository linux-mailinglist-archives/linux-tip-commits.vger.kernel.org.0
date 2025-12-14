Return-Path: <linux-tip-commits+bounces-7690-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CE3CBB880
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1AFE3009437
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5689E2F12DB;
	Sun, 14 Dec 2025 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gIs/Z5zO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xYjf6izv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082C12EBDD9;
	Sun, 14 Dec 2025 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701471; cv=none; b=eaTflNfqT7u5eD5CqA92e2XLc6+MhctP3RbpeIxVxjG9o6ykEYZF/8mKopKUlcD1TTPEokq/OsEq1UfFKMmDIMzNeCz37IuD20Jvs6m2K11nKUNOHCYgNk/SpKM599mcfRE08UI0BgpOdQdec4+fng7FuZZJSmZnYynLPDzawqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701471; c=relaxed/simple;
	bh=plTND4aaHBLA/I0tbvNbBIzadal++UM7xLDXkWWhZEM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kNMuV4jUlhFaxCiQiLuApkhEG9Lr7tAhZZCnI6qqTpKtcoySiPfNq3UUdZ1jx85+eQR02vIUzVfyrLUVe53IYX8z8AyzzRj0DiMyUsunuSIq6Tb1nEvlWnTjsRaX6ogioWpsfL8OStDcE2tlg8a/ViprBVdCqs+M7zWKTEx5oLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gIs/Z5zO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xYjf6izv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701467;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fuPBrAaQPeiG7Nwfux+daxxcdg34pw63g1v2XbUyRsU=;
	b=gIs/Z5zOmHyh3pY8Z7VdZ66JclTP/NzZZO1VdLblcrAiKEEQXxeYYliRdMVEQLydhpUmTq
	8BnYX7dYLfbPWK0c6JWHQ38krZ7dOdYw0ni/xM8KMOoPNFHgTJbQqcc2k5cqKZ1ksznTUQ
	JQ1E7PyxLDu2aRaf6kKOxukWr29HP1zUxSLEkEYu2VT+m61FgOTP/JMxv2vnS0L0eU5htt
	gZCem/iPJf+FZ7XdvjGMHWhywj9IbB+yCK2oen2Pv1wKcNzU3QwE5ae7B4GuM0FlzbW/mm
	jh29pQEZbedrM0kk+UC0Wc8Ex5fuN6IMkUH3tm2lgloRNXCFqAaKfxiEdP7Y1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701467;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fuPBrAaQPeiG7Nwfux+daxxcdg34pw63g1v2XbUyRsU=;
	b=xYjf6izvlJrdjNLfbUKgFVcB67yM/y2BXMOJ7u2SIubTYhnumv0DsT5SHVcSOgbxALp7z1
	P5suE1UKYFYtBICw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot/e820: Simplify the PPro Erratum #50 workaround
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Shevchenko <andy@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-4-mingo@kernel.org>
References: <20250515120549.2820541-4-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570146639.498.17304505535216995399.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     3814bf08452ecfc6db0de53a2e4f977e9661c1f4
Gitweb:        https://git.kernel.org/tip/3814bf08452ecfc6db0de53a2e4f977e966=
1c1f4
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:19 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:37 +01:00

x86/boot/e820: Simplify the PPro Erratum #50 workaround

No need to print out the table - users won't really be able
to tell much from it anyway and the messages around this
erratum are unnecessarily obtuse.

Instead clearly inform the user that a 256 kB hole is being
punched in their memory map at the 1.75 GB physical address.

Not that there are many PPro users left. :-)

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://patch.msgid.link/20250515120549.2820541-4-mingo@kernel.org
---
 arch/x86/kernel/setup.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1b2edd0..a231b24 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1015,11 +1015,9 @@ void __init setup_arch(char **cmdline_p)
 	trim_bios_range();
 #ifdef CONFIG_X86_32
 	if (ppro_with_ram_bug()) {
-		e820__range_update(0x70000000ULL, 0x40000ULL, E820_TYPE_RAM,
-				  E820_TYPE_RESERVED);
+		pr_info("Applying PPro RAM bug workaround: punching 256 kB hole at 1.75 GB=
 physical.\n");
+		e820__range_update(0x70000000ULL, SZ_256K, E820_TYPE_RAM, E820_TYPE_RESERV=
ED);
 		e820__update_table(e820_table);
-		printk(KERN_INFO "fixed physical RAM map:\n");
-		e820__print_table("bad_ppro");
 	}
 #else
 	early_gart_iommu_check();

