Return-Path: <linux-tip-commits+bounces-4114-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA9DA5A3B6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 20:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B047188EBC3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 19:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF53235377;
	Mon, 10 Mar 2025 19:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yPwNAbMS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uSehyVr+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5616D22DF82;
	Mon, 10 Mar 2025 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634514; cv=none; b=qlYs42BxSrUpd/VtnB/E7VKbwGFCTyPw6YzBJ5QlhyOFiNoAwIJcoiIjE1wUAPkTkkZm8LAc/xItk4a7U/qFAVPqWPzt8zEf5UZnqFRxrSV8Hmx2AXdZixYdU83wFKM6AYSB4qNbcXEpFgAsFozHYRBfsDSmx6NZ9ZfH3SIX/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634514; c=relaxed/simple;
	bh=ANIq6j3myR9Obz/q9e0HvXfdB1ZmzrMo8ohwHCnQNT8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sYsFt8Gdwv0q4XDcaZPNSaxRxdi+Hvt/v9DBtI5kkrk/pHf7zMm2cKP3eKtbMTPhPH9W/I5QsUFWqFWeSB61+ovibfVVEQYzfm4f+tbQMWSGdAZgkFsziZgWg5cSdxMWky6vZzTywtYP+TKbD92qSQZjp2D6qfOQ079QPEzfK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yPwNAbMS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uSehyVr+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Mar 2025 19:21:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741634510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=599QZNlMfFAZa1S3BX5XfssZn2IuGwDxBQ9UA695eMI=;
	b=yPwNAbMSwDNcxOTLpMOYjqob8Uf1hCW4PqeH27mzjjg8I5lujFSAa3n27i2IcHPfWnQ8ip
	gsMIXgVWUQTIARP9dUozNQffHLz2pK+4q7eu+0DaWNokyt2CrXY+eV71g1fksnZwUE2oqa
	c7PblyvYXtPrHy1ZzlsOtjKtXY+OD8zAo0P4eWR1D3DRjbB0g8ay+uupQ6n/zxxY1HUX7q
	lvKRslQoap7HqQXoJy3nW6FIoUj1nH5Uy7Ha/I5bgkVYJ5nArodFqKvhR0RSYdpIYtCzaM
	1UCa6GxSr94KzGbpF/w4hj2ccdmCl06Phl8GkZfMvuuQ7oMrO51tGur5bYnISg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741634510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=599QZNlMfFAZa1S3BX5XfssZn2IuGwDxBQ9UA695eMI=;
	b=uSehyVr+OiADb+oXGiiLzE3pt+wpqNgLmGBBZo3VxzlRUbfeEa7z8Zqw8KUjyy17IW+/WR
	Nbl0Qm+k8auPLqDw==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/coco: Replace 'static const cc_mask' with the
 newly introduced cc_get_mask() function
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250310131114.2635497-1-arnd@kernel.org>
References: <20250310131114.2635497-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174163450903.14745.16641563607434815843.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     ec73859d76db768da97ee799a91eb9c7d28974fe
Gitweb:        https://git.kernel.org/tip/ec73859d76db768da97ee799a91eb9c7d28974fe
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 10 Mar 2025 14:10:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 10 Mar 2025 20:06:47 +01:00

x86/coco: Replace 'static const cc_mask' with the newly introduced cc_get_mask() function

When extra warnings are enabled, the cc_mask definition in <asm/coco.h>
causes a build failure with GCC:

  arch/x86/include/asm/coco.h:28:18: error: 'cc_mask' defined but not used [-Werror=unused-const-variable=]
     28 | static const u64 cc_mask = 0;

Add a cc_get_mask() function mirroring cc_set_mask() for the one
user of the variable outside of the CoCo implementation.

Fixes: a0a8d15a798b ("x86/tdx: Preserve shared bit on mprotect()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250310131114.2635497-1-arnd@kernel.org

--
v2: use an inline helper instead of a __maybe_unused annotaiton.
---
 arch/x86/include/asm/coco.h          | 10 +++++++++-
 arch/x86/include/asm/pgtable_types.h |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index aa6c8f8..e722545 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -15,6 +15,11 @@ enum cc_vendor {
 extern enum cc_vendor cc_vendor;
 extern u64 cc_mask;
 
+static inline u64 cc_get_mask(void)
+{
+	return cc_mask;
+}
+
 static inline void cc_set_mask(u64 mask)
 {
 	RIP_REL_REF(cc_mask) = mask;
@@ -25,7 +30,10 @@ u64 cc_mkdec(u64 val);
 void cc_random_init(void);
 #else
 #define cc_vendor (CC_VENDOR_NONE)
-static const u64 cc_mask = 0;
+static inline u64 cc_get_mask(void)
+{
+	return 0;
+}
 
 static inline u64 cc_mkenc(u64 val)
 {
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 4b80453..9c4d9fa 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -177,7 +177,7 @@ enum page_cache_mode {
 };
 #endif
 
-#define _PAGE_CC		(_AT(pteval_t, cc_mask))
+#define _PAGE_CC		(_AT(pteval_t, cc_get_mask()))
 #define _PAGE_ENC		(_AT(pteval_t, sme_me_mask))
 
 #define _PAGE_CACHE_MASK	(_PAGE_PWT | _PAGE_PCD | _PAGE_PAT)

