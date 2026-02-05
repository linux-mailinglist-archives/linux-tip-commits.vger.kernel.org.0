Return-Path: <linux-tip-commits+bounces-8207-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGWWGszBhGnG4wMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8207-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Feb 2026 17:14:04 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6D6F5105
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Feb 2026 17:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D56E730073EA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Feb 2026 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6921C42315F;
	Thu,  5 Feb 2026 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gJbSTLya";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8B4rAMtf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216612C11DB;
	Thu,  5 Feb 2026 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308041; cv=none; b=tHinTPSFRCXXQSkaUVjIgB/LPE2P8Q3xANSWNnYWIbUGEMhECq91ArR5GTiqn9wy2z8PBARmqaQht29R6+s1njp2Lw9J24C3j+mL3pRabxUNeoGQ/uwI7FbfaBTphQxO+YFg2vIND4AYRy9Bn2AgWu0pS7Ajb9sWDnR5828BEEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308041; c=relaxed/simple;
	bh=5cKQec07QSGoHNtxUzMZdHJzyg/jnEH99Nvw7ZWw2UY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Rsu0iI7JzY5r0GdFx7ohLxHlwTnTMzA+Azwv/JV+XU0aBH3ud8QUE1lrHrmPlDSolA/ONfwW+tIRlaylvd2psHVAOA5ps81JsF6csLtATkcaghwsocEmmEibr0QUpMCgLmTJYUWylfcZVBbXGQ9a5WzriM1ZrDWqexk9Ftq95AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gJbSTLya; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8B4rAMtf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Feb 2026 16:13:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770308039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5igIVuFroGWI2wLF2AKE3ET7Keo7e5WrPUwn2lZn8A=;
	b=gJbSTLya19uOKOak7CGpwkCPVa39AE+zZR920xQd2us6mKmJVxLwtBCgNKSZnhVR5erQrP
	mmGL/ufCSBf6UL/iQ8Gm6S2ifuI5Xu1Z52QQ5GkfKZ1nvJrHktKS7pbSrN/lSWaNo+VDJ0
	+ZRVlZFin9fiJ43+pjJhVbyFfXpRfW48jArZoaMyiZGwqjX1eKBfmOSnGoyv9LcWT2NQE6
	zKKvOye5tZhl6WXUFPQuC1ISEXqeCTZL1imVwtoH9vkMl/IZpaRMcytaFvV6Rf4u/hrh4r
	/iJAzEyfU8R/DcWDrjreCUNsyHciD6Ht+Tz4+pf8+J3OkXcpNLyi2OmZreB4aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770308039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5igIVuFroGWI2wLF2AKE3ET7Keo7e5WrPUwn2lZn8A=;
	b=8B4rAMtfX48BHNswIkOZ+cw+3WqBfrgfwkQxu3a4IY5df6zChREJPLVokkVW4dglnd/x0a
	MVXvpBVgGj4EpCCw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool/klp: Fix unexported static call key
 access for manually built livepatch modules
Cc: Arnd Bergmann <arnd@arndb.de>, Song Liu <song@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <0bd3ae9a53c3d743417fe842b740a7720e2bcd1c.1770058775.git.jpoimboe@kernel.org>
References:
 <0bd3ae9a53c3d743417fe842b740a7720e2bcd1c.1770058775.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177030803819.2495410.14095810882510508232.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8207-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,msgid.link:url,linutronix.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: DC6D6F5105
X-Rspamd-Action: no action

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     f495054bd12e2abe5068e243bdf344b704c303c6
Gitweb:        https://git.kernel.org/tip/f495054bd12e2abe5068e243bdf344b704c=
303c6
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 02 Feb 2026 11:00:17 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 05 Feb 2026 08:00:45 -08:00

objtool/klp: Fix unexported static call key access for manually built livepat=
ch modules

Enabling CONFIG_MEM_ALLOC_PROFILING_DEBUG with CONFIG_SAMPLE_LIVEPATCH
results in the following error:

  samples/livepatch/livepatch-shadow-fix1.o: error: objtool: static_call: can=
't find static_call_key symbol: __SCK__WARN_trap

This is caused an extra file->klp sanity check which was added by commit
164c9201e1da ("objtool: Add base objtool support for livepatch
modules").  That check was intended to ensure that livepatch modules
built with klp-build always have full access to their static call keys.

However, it failed to account for the fact that manually built livepatch
modules (i.e., not built with klp-build) might need access to unexported
static call keys, for which read-only access is typically allowed for
modules.

While the livepatch-shadow-fix1 module doesn't explicitly use any static
calls, it does have a memory allocation, which can cause
CONFIG_MEM_ALLOC_PROFILING_DEBUG to insert a WARN() call.  And WARN() is
now an unexported static call as of commit 860238af7a33 ("x86_64/bug:
Inline the UD1").

Fix it by removing the overzealous file->klp check, restoring the
original behavior for manually built livepatch modules.

Fixes: 164c9201e1da ("objtool: Add base objtool support for livepatch modules=
")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Song Liu <song@kernel.org>
Tested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://patch.msgid.link/0bd3ae9a53c3d743417fe842b740a7720e2bcd1c.17700=
58775.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 933868e..ef451cd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -682,7 +682,7 @@ static int create_static_call_sections(struct objtool_fil=
e *file)
=20
 		key_sym =3D find_symbol_by_name(file->elf, tmp);
 		if (!key_sym) {
-			if (!opts.module || file->klp) {
+			if (!opts.module) {
 				ERROR("static_call: can't find static_call_key symbol: %s", tmp);
 				return -1;
 			}

