Return-Path: <linux-tip-commits+bounces-6930-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2117BE2972
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 244C43420A2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF8F33EB18;
	Thu, 16 Oct 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kmj6npRw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HTkStwLe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFBD320CA9;
	Thu, 16 Oct 2025 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608422; cv=none; b=g/tamarcHWXKAsjJ0MSxvG+L/qqc2GqU8kspjL1d1+ROmdzUiam3X9dGWTUq9G5/xldpsgh2XzEbwj5zCftpsMTTBn1GdOtq9pZ5ox9u4FLjnOdOgRhr/m7F/9JwCvWrP8DgKeACnABmJJu+cufKpn2ffsWTUCA2RctUKU/KhwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608422; c=relaxed/simple;
	bh=9Pi2dHyzX2cB/KQThIMbzBMr4zwAsIqFmifrA0CdbkM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=BVg7hdOiuXxiKEgSZb6AlIUlBZ70LILawb4fQ70MrQ0VHDvVmosNu1GV9K2VHu5+oQw8oM+zmdAK1/0FFGcPEknSq87GEQLOKshoc3V8J2jwhfhqVUYXTs3yL+DwHtFIriF8Cqudy35TqFgkEprLmomh7cKAJulEBr7Mi5wVs2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kmj6npRw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HTkStwLe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rRqgEvAD7W1y+pKMsyOypLfd043/FJF8Xq9Ae92jSZk=;
	b=Kmj6npRw4Lz6SeCcIVj+HpXu0kCIcxzoYSlJhOoVCnIzux2AOHLQ4yJg3HNfB17gr0H5YR
	iH7LOn9HCnzIkMZXBScnkPkZUsX4N9yqpIleh8VKncIpyXNToGkn+G8CBXENz7NZ2Ndxd9
	E+p2pxsxqyqegXm73BFB89xkmOSPjn5phd8YOAnAtSFECDWhmJKvR8ss7DUseLcHPi92EY
	xb/lv80sEY5Amn9S5nrQKM2Ks/LW0rMogjaTx9gZg2EIuq69X+PawHh4rIVRPBzChiLkEH
	lBvhyDxGcQdyykqu4uCLQVn5ink38IOyDXCeIy8UZxieG02lfaPZMYiEbQ901w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rRqgEvAD7W1y+pKMsyOypLfd043/FJF8Xq9Ae92jSZk=;
	b=HTkStwLemVmOIxDGKGqIg0pZ+QW1A0ukDe3HqvQT6H+2fAIsbB3A37SZCBYPPEqmNdv1XW
	t+hK7JmkwBkuV0CQ==
From: "tip-bot2 for Dylan Hatch" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix standalone --hacks=jump_label
Cc: Dylan Hatch <dylanbhatch@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060840056.709179.17703718813399608345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     be8374a5ba7cbab6b97df94b4ffe0b92f5c8a6d2
Gitweb:        https://git.kernel.org/tip/be8374a5ba7cbab6b97df94b4ffe0b92f5c=
8a6d2
Author:        Dylan Hatch <dylanbhatch@google.com>
AuthorDate:    Tue, 23 Sep 2025 00:49:41=20
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:21 -07:00

objtool: Fix standalone --hacks=3Djump_label

The objtool command line 'objtool --hacks=3Djump_label foo.o' on its own
should be expected to rewrite jump labels to NOPs. This means the
add_special_section_alts() code path needs to run when only this option
is provided.

This is mainly relevant in certain debugging situations, but could
potentially also fix kernel builds in which objtool is run with
--hacks=3Djump_label but without --orc, --stackval, --uaccess, or
--hacks=3Dnoinstr.

Fixes: de6fbcedf5ab ("objtool: Read special sections with alts only when spec=
ific options are selected")
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a577057..b0e6479 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2563,7 +2563,8 @@ static int decode_sections(struct objtool_file *file)
 	 * Must be before add_jump_destinations(), which depends on 'func'
 	 * being set for alternatives, to enable proper sibling call detection.
 	 */
-	if (opts.stackval || opts.orc || opts.uaccess || opts.noinstr) {
+	if (opts.stackval || opts.orc || opts.uaccess || opts.noinstr ||
+	    opts.hack_jump_label) {
 		ret =3D add_special_section_alts(file);
 		if (ret)
 			return ret;

