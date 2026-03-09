Return-Path: <linux-tip-commits+bounces-8405-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IPfLaklr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8405-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:55:21 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F682406AA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86252301151F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8039E413256;
	Mon,  9 Mar 2026 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tis06hl0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j6q6SKE/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E91325495;
	Mon,  9 Mar 2026 19:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086058; cv=none; b=bE4S4b2zho+s4C9a8p7KER3JW/fWvL0gbREwEGXBpT6YdWiB5orhzQADIAruiTBwvFaAB12pSvlys+RPVRzFmrNexUwS6rIRMONfG8jNQ0iyidFPVOM7ra9cr+IHMG3wsPZBFXYfw/I5p3nCr+Nki6YZNgn0UNNTuJt2Q2yJu/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086058; c=relaxed/simple;
	bh=0vbcLE1BZfHARoRo7r1A0gIm6udF7yfUpj/qvjz6HNc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fkon6nPdExvHUjxzBDPhw+uRxJL/aRb7NUImY+WHQmpS/HFAaw+XIxz139oOp1kCGVRCpw7ZKGqCkFuEL1aQBde9oMuGCptzWMs/dRuYisWGFTl7XCkiKN0UwMBsDPtnR6IKHFsuGfgv72NwedZyIIE5xzk+tnXyARY3L6gxx8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tis06hl0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j6q6SKE/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:54:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773086055;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0BBKfNSM3OuzKHNSD7bxvvm9yuRztq88ULnYBrutmVM=;
	b=Tis06hl0NRkebuKmijy6U0TaK758A85M/P62VoU1rXyMZJcY4flJHCMWa67QvFO0zli6eh
	dFDQ4r8lOsNQ+f5TpMH5TvcgDg3pa5fvf/PFOLkxD3OP0tpa/8FmcdwSeJRsk1nU/XxwmF
	uD6gMRCV5mhD3jfagTRE3TH4XEjl60hTW9K1aK2EMnB8BZyBMXAs9URKlnTqS6PrtptwBl
	NLqdx87orJcfSAARhOT9qtjf2tbigjtpjMM7ghtSIngKYmtLMHrk5+q1CtXPA8CcCzQC77
	jSAVsL9YRNACDTswj8EHLhYbqewc8CgLi2Vk09fEi1oxAsZSitJAZpqi+6A2uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773086055;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0BBKfNSM3OuzKHNSD7bxvvm9yuRztq88ULnYBrutmVM=;
	b=j6q6SKE/zOs+nrdiiVnPY0Llt+Zibb6TW/0HbFBSAGK2RpKeYZfhmBl6dVWaKHG01ypW0q
	v2wLaCrFblrtxWDA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix data alignment in elf_add_data()
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <d962fc0ca24fa0825cca8dad71932dccdd9312a9.1772681234.git.jpoimboe@kernel.org>
References:
 <d962fc0ca24fa0825cca8dad71932dccdd9312a9.1772681234.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308605456.1647592.11258228783929326420.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C2F682406AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8405-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     356e4b2f5b80f757965f3f4d0219c81fca91b6f2
Gitweb:        https://git.kernel.org/tip/356e4b2f5b80f757965f3f4d0219c81fca9=
1b6f2
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 04 Mar 2026 19:31:20 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Fri, 06 Mar 2026 07:53:36 -08:00

objtool: Fix data alignment in elf_add_data()

Any data added to a section needs to be aligned in accordance with the
section's sh_addralign value.  Particularly strings added to a .str1.8
section.  Otherwise you may get some funky strings.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing =
object files")
Link: https://patch.msgid.link/d962fc0ca24fa0825cca8dad71932dccdd9312a9.17726=
81234.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 2c02c7b..3da9068 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1375,7 +1375,7 @@ void *elf_add_data(struct elf *elf, struct section *sec=
, const void *data, size_
 		memcpy(sec->data->d_buf, data, size);
=20
 	sec->data->d_size =3D size;
-	sec->data->d_align =3D 1;
+	sec->data->d_align =3D sec->sh.sh_addralign;
=20
 	offset =3D ALIGN(sec->sh.sh_size, sec->sh.sh_addralign);
 	sec->sh.sh_size =3D offset + size;

