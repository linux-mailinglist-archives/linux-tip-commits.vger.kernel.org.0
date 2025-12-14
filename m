Return-Path: <linux-tip-commits+bounces-7684-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 995AECBB871
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CE9E301DB90
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496962E0926;
	Sun, 14 Dec 2025 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQlyhXIG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dzEfIEfd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE1D2DEA97;
	Sun, 14 Dec 2025 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701465; cv=none; b=hWrs0EHkZCOZPebB6MDT0rq978xcFqNcCCAgyUMFMb0VXH+hJWD5NgVJUaU/6t6EfRigcdBdSKJyVOWIJpnsKGlXPm7L/gKR11/3CTphJcVPr8QszN4Z81WyRbCYrpaWalQUmnGjysekRwK7gG4KjDJDYYHwNJI6N/DXYNd24F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701465; c=relaxed/simple;
	bh=V//l2CbejFR+d1/QrAnxUMwAMo+CMuNOx9M6OasBap0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EtceEazV4QPqjU7Tpx9g3V0Ur9RiNCqVwvp9guTVXUftqh1eI/RzbZUnlNedE1cbW47qiFPNB0fqPazP5L1zYARkIMbxBqzo/5YHyAFf6qakwTA9KQ6mN5zjc+8hrXtomq/zHvkzwfDg6xwL3rCuELv/Niavc4j6RGK7tnHAVJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oQlyhXIG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dzEfIEfd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FO9xNz3BVcgn9lOo0LnAoyUbI8J/1I8ijJWnPn9waz4=;
	b=oQlyhXIGvaO1ZneHZket9889R2AY8g2qZjO0//awQjYF8c55ccReXQ548waXm14QLJlOWW
	uzOF/dwj7JYtlq+pEUa9rLAlA7lmrXXGijRjlIy7ZRKn+f63L6AgBSD5C6OncxbTJSCRfi
	JzbIw6ExDt8L8F3uW0jeL36/T/8364xY8igLSors9edAi5mBmSNxcspupFeOhbIpyg6vrb
	wt1TK1FntTOrI/qPHIRMHMJGYFHf60/fT+toiLogha9zSMhKbVTtxO+pX3x4ooej6FNS2D
	6HeEChqT43UKLyepzLuH1UqjrxTix6nKRwFSD9wZHMNCq+ZI0KT5/pm0X7Enjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FO9xNz3BVcgn9lOo0LnAoyUbI8J/1I8ijJWnPn9waz4=;
	b=dzEfIEfdELXbwfqrfAMzxEdfQJD2/hNdRVSbluIHhaS9xUHFDszeOqV1RqxGwiRixc5u/X
	43xat0Lwdyb/RkBA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Use 'u64' consistently instead of
 'unsigned long long'
Cc: Ingo Molnar <mingo@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Juergen Gross <jgross@suse.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-11-mingo@kernel.org>
References: <20250515120549.2820541-11-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570145964.498.17316634218358388875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     eea78dc546a95af343fd1463ecfbd250f0abbf22
Gitweb:        https://git.kernel.org/tip/eea78dc546a95af343fd1463ecfbd250f0a=
bbf22
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:26 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:38 +01:00

x86/boot/e820: Use 'u64' consistently instead of 'unsigned long long'

There's a number of structure fields and local variables related
to E820 entry physical addresses that are defined as 'unsigned long long',
but then are compared to u64 fields.

Make the types all consistently u64.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://patch.msgid.link/20250515120549.2820541-11-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 96840fa..0378648 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -296,7 +296,7 @@ struct change_member {
 	/* Pointer to the original entry: */
 	struct e820_entry	*entry;
 	/* Address for this change point: */
-	unsigned long long	addr;
+	u64			addr;
 };
=20
 static struct change_member	change_point_list[2*E820_MAX_ENTRIES]	__initdata;
@@ -344,7 +344,7 @@ int __init e820__update_table(struct e820_table *table)
 	struct e820_entry *entries =3D table->entries;
 	u32 max_nr_entries =3D ARRAY_SIZE(table->entries);
 	enum e820_type current_type, last_type;
-	unsigned long long last_addr;
+	u64 last_addr;
 	u32 new_nr_entries, overlap_entries;
 	u32 i, chg_idx, chg_nr;
=20
@@ -641,13 +641,13 @@ static void __init e820__update_table_kexec(void)
  */
 static int __init e820_search_gap(unsigned long *gapstart, unsigned long *ga=
psize)
 {
-	unsigned long long last =3D MAX_GAP_END;
+	u64 last =3D MAX_GAP_END;
 	int i =3D e820_table->nr_entries;
 	int found =3D 0;
=20
 	while (--i >=3D 0) {
-		unsigned long long start =3D e820_table->entries[i].addr;
-		unsigned long long end =3D start + e820_table->entries[i].size;
+		u64 start =3D e820_table->entries[i].addr;
+		u64 end =3D start + e820_table->entries[i].size;
=20
 		/*
 		 * Since "last" is at most 4GB, we know we'll

