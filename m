Return-Path: <linux-tip-commits+bounces-7121-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AB7C278E6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 07:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDC1189C4EB
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 06:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDDD223DD0;
	Sat,  1 Nov 2025 06:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GzQU4lsu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1qygoNNm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D01157493;
	Sat,  1 Nov 2025 06:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761979808; cv=none; b=Y4hi51tvp+yOfpasSafP5x7cVMK2evHczIjDpNBGZXLMwxdjde/qz0tUZ/JVudXKZV+n1qAARqpnjopc6zcHnstKn9K+zq0vIW4T1SItk2Cm9j0amRGZ1kzk+Mi0g/50wkGR/DwxVKNp8Bjojth3+McFG8SGeQq7qExnTsD+i54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761979808; c=relaxed/simple;
	bh=0D0kb0ufIvcu53AfveP+YgjmVQjJ0Wnlmg+dzhdj3m8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J2cV9e++CfCkg0TnSExhy1DHmfLpNI7PDSEuwzsQbhGTK5mIe6CL5uGAQVTw6lIHuzKde6akP2KuBJgXgsFzOsPTDUoZpkIbqKMMscqqBDmsCMfb1vq/0PbLoKnNsqkUfcjEwnaS8wGngOMKOOeuondCBdlK9+mp/Ujfvkea5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GzQU4lsu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1qygoNNm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 06:49:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761979804;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnCpp0dWSEXxUbQG8kuZww0Ab8O2Wi0yBTzG8Km61JI=;
	b=GzQU4lsuAZbQYSKO3+T6icsXXNcgzuPkcd2jrvVNH4rpO7B8N4IUoRu1jRQYO3xRhq1Dtr
	u73F28EnsVdIXtCfymWnIagYfX72tEwZ8blUgmWXgH7pyH9gaOUcFvxTP99UdxGLUt5JDZ
	39FhqCgXm9j2qWuICBfTPpxeACsFtUI81V4U18Ad/BSuHtMCouBrWIwWpzzSnWxMT312LF
	CsHwm/VlnrMRX1RqeW6yGxgCVpwxA8kBHbGHK4Ut24tIDBX/PD91eU25eX4zrVoJLaZP7N
	stQ/C8AFj0UkN8FvgkKIfhZODZFrmcShG63QjwUKfarKNP5onbB3SqcMA8FGfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761979804;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnCpp0dWSEXxUbQG8kuZww0Ab8O2Wi0yBTzG8Km61JI=;
	b=1qygoNNmooq1z336lNTZAKWPAnpduPM6ftXjhw+3joMlLe3suZCsNbggahZCK/ayEPmsgo
	Ze33kKx5ZD3XI8Bg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix skip_alt_group() for
 non-alternative STAC/CLAC
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <3d22415f7b8e06a64e0873b21f48389290eeaa49.1761767616.git.jpoimboe@kernel.org>
References:
 <3d22415f7b8e06a64e0873b21f48389290eeaa49.1761767616.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176197980001.2601451.6742184653281024992.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     c44b4b9eeb71f5b0b617abf6fd66d1ef0aab6200
Gitweb:        https://git.kernel.org/tip/c44b4b9eeb71f5b0b617abf6fd66d1ef0aa=
b6200
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 29 Oct 2025 12:54:08 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 01 Nov 2025 07:43:20 +01:00

objtool: Fix skip_alt_group() for non-alternative STAC/CLAC

If an insn->alt points to a STAC/CLAC instruction, skip_alt_group()
assumes it's part of an alternative ("alt group") as opposed to some
other kind of "alt" such as an exception fixup.

While that assumption may hold true in the current code base, Linus has
an out-of-tree patch which breaks that assumption by replacing the
STAC/CLAC alternatives with raw STAC/CLAC instructions.

Make skip_alt_group() more robust by making sure it's actually an alt
group before continuing.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 2d12c6fb7875 ("objtool: Remove ANNOTATE_IGNORE_ALTERNATIVE from CLAC/S=
TAC")
Closes: https://lore.kernel.org/CAHk-=3Dwi6goUT36sR8GE47_P-aVrd5g38=3DVTRHpkt=
WARbyE-0ow@mail.gmail.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://patch.msgid.link/3d22415f7b8e06a64e0873b21f48389290eeaa49.17617=
67616.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 620854f..9004fbc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3516,8 +3516,11 @@ static bool skip_alt_group(struct instruction *insn)
 {
 	struct instruction *alt_insn =3D insn->alts ? insn->alts->insn : NULL;
=20
+	if (!insn->alt_group)
+		return false;
+
 	/* ANNOTATE_IGNORE_ALTERNATIVE */
-	if (insn->alt_group && insn->alt_group->ignore)
+	if (insn->alt_group->ignore)
 		return true;
=20
 	/*

