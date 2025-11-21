Return-Path: <linux-tip-commits+bounces-7451-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EACC784AD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 11:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 09ACD2E8CC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 10:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D77346E56;
	Fri, 21 Nov 2025 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OY4CqPyj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MXQotdL8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC78D346782;
	Fri, 21 Nov 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719083; cv=none; b=QcI6l4+5sCf6fy9pheLGpesIWpLJmqeXadBTJ4Er3aGEy/DKXQKeKyS3rdoViOk7w+fMCKCM88z+9JrGQpBYc0dwJKbcGOMewNh4BwzfsRlNIgP+OEcN5dEu6M8VzUz8O+p7f5G9jjMHluL7qAn+Vtqqg3OpOSXVroBoE16ebrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719083; c=relaxed/simple;
	bh=W04tj+jsK3nFYDa9ruYCXsDl2qrsIxlifB5/H5HhMw8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PavR6TIiD59o6NmZoNTaFYX8x4gziw8fYG+6QC2pbalY9swTxzsX1Z1uzuxlWmzMKhr4uOXkkJcFBOjrc1Y0T0UhV8SLopiH4hcVI2jps6IQ1LUmpE3fleepS2YK7onpG3E8d7bctFjtoXzG4i6YCT1ym+vmAj+A+LFXHjiMERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OY4CqPyj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MXQotdL8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 09:57:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763719080;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNNIRcoPEySABAmkgAx4Y17gQG3OarZXkFgfsnlJqFM=;
	b=OY4CqPyjSE3K00e8STWdKZx1yiP/b38HnI0gFOgSkMD5ZjpaD3eAQWY1A7X09N8xgKCdM4
	KVoB5cTJ7YYguT1n9LI5ZJkSZrFCSV4f20W0Cn0VUPCj9fKNyO4UTGC9C+t2bk2L1FbQYR
	V60ZgeSvaZ1PlBIvpdRhlFX7u28d34osimjbwDLq8uh7p/UWtR9T+9RO1pcRfXLE0Bf3U8
	Esr0N5wX4QNqvFK6THealZSa8NZ+3VhOOSgOVynLTYFWkspdXFLeTeMaXMvWFR+LoUlQts
	u6C3XMkBoS3DZLn328pjAScUuJPBAhCQoZX5wkk8jXxtbiSnJ7IGxc9DziDPqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763719080;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNNIRcoPEySABAmkgAx4Y17gQG3OarZXkFgfsnlJqFM=;
	b=MXQotdL87elDgZeeHm37OH5mYrtxmB6YBlovTMY8uUZ3OT/+OCXMS4JHx5FI7M7o+Vpl4p
	6SWiFTx7axtLZUCg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Don't alias undefined symbols
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <bc401173a7717757eee672fc1ca5a20451d77b86.1763671318.git.jpoimboe@kernel.org>
References:
 <bc401173a7717757eee672fc1ca5a20451d77b86.1763671318.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176371907884.498.8805779246600094962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     16f366c5a68839736d3616b466f1738811408ec7
Gitweb:        https://git.kernel.org/tip/16f366c5a68839736d3616b466f17388114=
08ec7
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 20 Nov 2025 12:52:17 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 10:04:08 +01:00

objtool: Don't alias undefined symbols

Objtool is mistakenly aliasing all undefined symbols.  That's obviously
wrong, though it has no consequence since objtool happens to only use
sym->alias for defined symbols.  Fix it regardless.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/bc401173a7717757eee672fc1ca5a20451d77b86.17636=
71318.git.jpoimboe@kernel.org
---
 tools/objtool/elf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index fffca31..4f15643 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -492,8 +492,8 @@ static int elf_add_symbol(struct elf *elf, struct symbol =
*sym)
 	sym->len =3D sym->sym.st_size;
=20
 	__sym_for_each(iter, &sym->sec->symbol_tree, sym->offset, sym->offset) {
-		if (iter->offset =3D=3D sym->offset && iter->type =3D=3D sym->type &&
-		    iter->len =3D=3D sym->len)
+		if (!is_undef_sym(iter) && iter->offset =3D=3D sym->offset &&
+		    iter->type =3D=3D sym->type && iter->len =3D=3D sym->len)
 			iter->alias =3D sym;
 	}
=20

