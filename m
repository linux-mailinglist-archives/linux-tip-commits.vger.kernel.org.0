Return-Path: <linux-tip-commits+bounces-5860-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E6CADDFBC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Jun 2025 01:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF2D189B83B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Jun 2025 23:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DF31EA7D2;
	Tue, 17 Jun 2025 23:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="esMCtyII";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WBqw3k40"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC722F5326;
	Tue, 17 Jun 2025 23:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203271; cv=none; b=Zwteb9U8Q7y+x0CPf6IyiKvmFMtvEn5R3ZNF8HRhHdqOj9F9fZGG2ICA1IRUVyyYjFT5BPhymELF4GlmE46QjfuH43dosS14sTOZAeVCGBoHM0Zo/metD6FAWL+ukaE4Qf6EIzXkhZ/KrNXO7QPWR0pXS6Es0220Ouf5hulknO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203271; c=relaxed/simple;
	bh=oZPYI309J/U93c7kpIV29ggMe76bat7e5UmdmKCbRwY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=gk9eOeJNnAkdohJv7RWi2/cRz6PxN8JTZ0R6dOimXbeW/+qrYNcc5lP/f4kwQG/Ns1ZewpVxDF9l5CI+pigMK2NXk+KI/ri4rAoTWkmTMY+MFNg9DiRXOPTEOq9qup6PA0/LR3VCCqlS+cFKfF0dTLpFENuVC/Z+ZOXIOilndEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=esMCtyII; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WBqw3k40; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Jun 2025 23:34:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750203267;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=2Rif5vJkFVsJ24ErE3jEirnmoA4XHvgFf9yZDniMFWQ=;
	b=esMCtyIInkmb+CmtPJwHAIAPzZuhbUmUiig46K3RxdVYABkOWnJhK+SXG6IgFjgdqsFIXP
	Bl3cuH+WRq7Our02pNFkcIeY0WzJbJ2lBpn2tzLw0iKWGUCxn9KdkOkeUbpopi4wjzhSaq
	qt/bn7jcFt5kVT6NNCa/PfhZCtyXzyzQnkFgB6U7tyY0xZHdRMEis1tRyXm+bcaqxI6v3I
	tNN4s4PW/opvXrXRZ03Vl7Vj/RawStYkebC/dp0IxdxkNyvLhzFD/0o/xCHwof/QvY0tz3
	LAFD9srsOYZtSYqUiJrBNCP4Eg19YORDu7GZJ6FTK6dXd3CForxW7113+T0sig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750203267;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=2Rif5vJkFVsJ24ErE3jEirnmoA4XHvgFf9yZDniMFWQ=;
	b=WBqw3k40XXVdBDyBN4nc0AmkVpJ1pMbgGVIwrd7XbcGzK6mfJBiM4EhN1frJna45fKU96N
	RtOk70P2/1zaJJCw==
From: "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/its: Fix an ifdef typo in its_alloc()
Cc: Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175020326650.406.9400096129663103162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3c902383f2da91cba3821b73aa6edd49f4db6023
Gitweb:        https://git.kernel.org/tip/3c902383f2da91cba3821b73aa6edd49f4db6023
Author:        Lukas Bulwahn <lukas.bulwahn@redhat.com>
AuthorDate:    Mon, 16 Jun 2025 12:04:32 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 17 Jun 2025 16:10:57 -07:00

x86/its: Fix an ifdef typo in its_alloc()

Commit a82b26451de1 ("x86/its: explicitly manage permissions for ITS
pages") reworks its_alloc() and introduces a typo in an ifdef
conditional, referring to CONFIG_MODULE instead of CONFIG_MODULES.

Fix this typo in its_alloc().

Fixes: a82b26451de1 ("x86/its: explicitly manage permissions for ITS pages")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250616100432.22941-1-lukas.bulwahn%40redhat.com
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6455f7f..9ae80fa 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -228,7 +228,7 @@ static void *its_alloc(void)
 	struct its_array *pages = &its_pages;
 	void *page;
 
-#ifdef CONFIG_MODULE
+#ifdef CONFIG_MODULES
 	if (its_mod)
 		pages = &its_mod->arch.its_pages;
 #endif

