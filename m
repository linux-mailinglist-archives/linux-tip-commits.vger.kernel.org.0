Return-Path: <linux-tip-commits+bounces-6904-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1E1BE291B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9AC19A3D5C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF76A3375C0;
	Thu, 16 Oct 2025 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n+zIqdPT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rsG5Rd7x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C800C32F76F;
	Thu, 16 Oct 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608399; cv=none; b=anvRfJJfVLW4fIbSt7KynvpZB5ebukXyjroysHGFdmwVXNxXMDOifdRmxTKAI3shg8RPPwBwcdtMJ/nzDyBzs3GonOeBVKlC44xJJo5aVk8f6WMUvIPJd42EyQbmRNAOWj3a/t56HLvEvZcXG//BSAH1SPfBuTqTqLeX772JWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608399; c=relaxed/simple;
	bh=vNCo7CP4Nsd1csHNn1UF5uq8HWLWz48pqyJ90NtgYfk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Ae5kGN8Cx4JgLrI9eVi6RKKCYLi0slo7IUfbe1BQVnCnBrCzpNlsS6SaEEm9xaKLatRhvK2PP/op3sWr3T6/xnPUEHdz27ZoN3xBh7asvjPNdakE8lfRD7PiA7ZDcOLsEJalNI2l1ChWdTtgTa1PEdSUVIBeVEMSGpIQykPPUgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n+zIqdPT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rsG5Rd7x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608375;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fiFaQBJhgrFsAUrhVm302WwrDjzlhhMuXalIM7H+ZmY=;
	b=n+zIqdPThAFWocrxCNtUMNMvFcis+PsVaGrP3jz1L81nR32FJey8lSciyB77cR8wEw4BNS
	2eg3z6mOGLvwjpclSwS3tEArrG+kLsS99B04hW3SGIYUxRbUYpBX6oMusyUFK7B3r1KRIL
	mO+MGGsCd2Imtz2ZSpQZQzzjWxCe74HW8omSGqRGKPQ6UKV7gqvrK+Bm6WOBRDJoWeMlCg
	VwAds1bN1bDnHUvugoPshNsdaOxgWayjj9A+dL4Odn6QeiEdoUHki2BJmrUeZd4WfLxuyj
	DMll5Tg1wmcIRZAqXSkjBSiqjlPf2zs3sbJxS4kF+AEfNxFotA2sObNQKnu/iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608375;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fiFaQBJhgrFsAUrhVm302WwrDjzlhhMuXalIM7H+ZmY=;
	b=rsG5Rd7xBJSmi/d+5LC1oxpleuiCWwPeMgbj8f8ASXNmAhwCGrKG9V6muTKznJfKFJABpH
	S/wdBJ6GMq3/VxAw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix "unexpected end of section" warning
 for alternatives
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060837360.709179.3733383336366312679.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4cdee7888f42f5573b380ddfa9da43208e759bdc
Gitweb:        https://git.kernel.org/tip/4cdee7888f42f5573b380ddfa9da43208e7=
59bdc
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:30 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:24 -07:00

objtool: Fix "unexpected end of section" warning for alternatives

Due to the short circuiting logic in next_insn_to_validate(), control
flow may silently transition from .altinstr_replacement to .text without
a corresponding nested call to validate_branch().

As a result the validate_branch() 'sec' variable doesn't get
reinitialized, which can trigger a confusing "unexpected end of section"
warning which blames .altinstr_replacement rather than the offending
fallthrough function.

Fix that by not caching the section.  There's no point in doing that
anyway.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 65eb900..c2e46f9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3512,15 +3512,12 @@ static int validate_branch(struct objtool_file *file,=
 struct symbol *func,
 {
 	struct alternative *alt;
 	struct instruction *next_insn, *prev_insn =3D NULL;
-	struct section *sec;
 	u8 visited;
 	int ret;
=20
 	if (func && func->ignore)
 		return 0;
=20
-	sec =3D insn->sec;
-
 	while (1) {
 		next_insn =3D next_insn_to_validate(file, insn);
=20
@@ -3760,7 +3757,7 @@ static int validate_branch(struct objtool_file *file, s=
truct symbol *func,
=20
 			WARN("%s%sunexpected end of section %s",
 			     func ? func->name : "", func ? "(): " : "",
-			     sec->name);
+			     insn->sec->name);
 			return 1;
 		}
=20

