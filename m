Return-Path: <linux-tip-commits+bounces-4744-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FC2A7F763
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 10:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF89179AD4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10467263C74;
	Tue,  8 Apr 2025 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A4QFAeyX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j8i3TDK7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A2A261584;
	Tue,  8 Apr 2025 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099942; cv=none; b=ffDO/5iV7YQ0K1BmWR2uAdDkYHPeqtTYE70PDjvmq9MS3/fy6ARiVjwZQoW5nBmIJdQEi1mYm7xu1oBoQW669bIZ4cpmOjLn4r89ijHX7INjTxKGhGiRR9kEgnaU1zBlv+7aW5SelELtG58ZFeH09ybGR+na/NhkWJNMhec08Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099942; c=relaxed/simple;
	bh=Q4ERd39Qd2iT0VuXxSJOabw3G0siTL1uCCwfMQG8crI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ROxw8mQprkzTkb+GeExO++tcN6AwmbBnhbPBoBQw9TOPuxu1IMoUdRyqcx9lu5eViWM/IoqzGFnMZ6fZSH39vindYkESPOs9C+5pTFQu8M20BKk73aDIBBphYkxe61Bztxz3nH7rsSIJrujyOMxzvoonniwr36AbutEYO2D2Qsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A4QFAeyX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j8i3TDK7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 08:12:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744099939;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hcHc6xcdVh0pDq7WsXwHhFwMuMGH5OqXpAp9BV9fRJ4=;
	b=A4QFAeyXPu5ywPPFskqFs23Z4lgGS/nvrHXHO9Lhd5kKBZUYQJIJmO8aH9mU7zq3xK1DXh
	CZGsLisFXfBiYJ9yZwwmZjFYsRJ0lBSjMi/aAG9IZY4Kymnyq6xYh+kmaNxMUGzh1si+al
	SP092m7KYYsLe4PwgbPDgI1HBDcroUXp+PhPFwhEOo0cFHdSsJ7lZv2oPBqYEG2iIekQrh
	zzieHj27o6ASvLD+19YuszdwBRCsNYcsDxJ7Usawe6C39XBYB3z+jtixIQoM5zvIV03Zml
	PjnY4AT4XYxvQEooZap9hvlCBNwSFeT0dwOD03qP6Th7Maj1i5Lzqv/R5zUUdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744099939;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hcHc6xcdVh0pDq7WsXwHhFwMuMGH5OqXpAp9BV9fRJ4=;
	b=j8i3TDK7SRyoy8qV0QuYP+JddFXsFy8lgMOAYMUGjkx2FFVVKmTrUKlmB99pPGvuOphy9+
	8Ue9fpIUn72ctADQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Stop UNRET validation on UD2
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <ce841269e7e28c8b7f32064464a9821034d724ff.1744095216.git.jpoimboe@kernel.org>
References:
 <ce841269e7e28c8b7f32064464a9821034d724ff.1744095216.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174409993893.31282.10039220045046805146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     9f9cc012c2cbac4833746a0182e06a8eec940d19
Gitweb:        https://git.kernel.org/tip/9f9cc012c2cbac4833746a0182e06a8eec940d19
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 08 Apr 2025 00:02:15 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Apr 2025 09:14:11 +02:00

objtool: Stop UNRET validation on UD2

In preparation for simplifying INSN_SYSCALL, make validate_unret()
terminate control flow on UD2 just like validate_branch() already does.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/ce841269e7e28c8b7f32064464a9821034d724ff.1744095216.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2c703b9..2dd89b0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3902,6 +3902,9 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 			break;
 		}
 
+		if (insn->dead_end)
+			return 0;
+
 		if (!next) {
 			WARN_INSN(insn, "teh end!");
 			return 1;

