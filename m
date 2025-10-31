Return-Path: <linux-tip-commits+bounces-7110-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E874C24B03
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 12:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26805426C7F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 11:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9803451AD;
	Fri, 31 Oct 2025 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xdnq6jgv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SXllM1QY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8138B3446A5;
	Fri, 31 Oct 2025 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908652; cv=none; b=jlcSgmLOMEcQQu79IWWRNu9LajRfJvi6VReAgoFerTUmdM5FL8jEvyAlJJAm5i29gjV/wdqDkc5vWNQDA18Glz3Q9UmccZqBCYpuNeDCC3+DRhDClgxnkNGZyBAkHl7Jt5xcX/h4HE2xj6mKp8KBtw4LToX+QNBwTMhh0wQgsHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908652; c=relaxed/simple;
	bh=EfuYxps5kPC/dm27s+b43ExGaaZW8aR6B4vfh44GjOQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DiGlAWgsen1yqp8WXqn3j9eYNwFiR8x5G+pdGqF9tKOqurtnMWW+HhoGlPaChfr+oUNOs2rbmughScwa/jNGXsiB/1S3dIzRPlZy/b3c7xLBdHA6fisnwjafde+hYgzLUNr7SM1aj97S/xyYlfWtt2kzqBypm71GMvHAR27lco4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xdnq6jgv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SXllM1QY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 Oct 2025 11:04:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761908648;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+fPRnDi/aUs2tqm3Phrh5nsbwtxAreFLmhblcik1n8=;
	b=xdnq6jgvwhc9WMsqM5w4lx3yb/donZRXGeahikGumnlPydlDF5C0bAiawkTXOgJDEbnbKl
	n2tVTQH+dfkVxHkePpsje6+auzQ/kT7y/Y3SmpJyqf2lY7nz1l33AzAifakzBIEHE9IjLq
	T0Qjkk9Sk9geXB8uWpqhZHp+eAoFibsP7UFht71MjJREWMEWVUehqejEKaDG3ksdIKsK5a
	BLViFUnlf9GgD/TkuAnv254eggW3NOk19tjy3Ub4mSr9hDu52LW7aKsr7NAH1kdX5yWLGa
	5y7PcgfbUBaKQPpRPc8JjOdrObUzVhqq3t5xYYGHWIxV76KuExpbuDqc9Qzl6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761908648;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+fPRnDi/aUs2tqm3Phrh5nsbwtxAreFLmhblcik1n8=;
	b=SXllM1QYs3jlpgyH9H9ORF2VbLGT5/2dO6xOwi8PuEGJ5d9yINjSN3EwmNPLbGEaCpssis
	xshSEdJx3dKOO7Bg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix skip_alt_group() for
 non-alternative STAC/CLAC
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
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
Message-ID: <176190864734.2601451.2024046536181824551.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     2c132efb3a443ab22f3b05e547ccc42bf2ee5abf
Gitweb:        https://git.kernel.org/tip/2c132efb3a443ab22f3b05e547ccc42bf2e=
e5abf
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 29 Oct 2025 12:54:08 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 29 Oct 2025 21:23:49 -07:00

objtool: Fix skip_alt_group() for non-alternative STAC/CLAC

If an insn->alt points to a STAC/CLAC instruction, skip_alt_group()
assumes it's part of an alternative ("alt group") as opposed to some
other kind of "alt" such as an exception fixup.

While that assumption may hold true in the current code base, Linus has
an out-of-tree patch which breaks that assumption by replacing the
STAC/CLAC alternatives with raw STAC/CLAC instructions.

Make skip_alt_group() more robust by making sure it's actually an alt
group before continuing.

Fixes: 2d12c6fb7875 ("objtool: Remove ANNOTATE_IGNORE_ALTERNATIVE from CLAC/S=
TAC")
Closes: https://lore.kernel.org/CAHk-=3Dwi6goUT36sR8GE47_P-aVrd5g38=3DVTRHpkt=
WARbyE-0ow@mail.gmail.com
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
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

