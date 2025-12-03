Return-Path: <linux-tip-commits+bounces-7589-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFEDCA0C40
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 19:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C70A300646A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECB233A701;
	Wed,  3 Dec 2025 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ulrc0nUn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7602F2877CF;
	Wed,  3 Dec 2025 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764785261; cv=none; b=bVLUghIa2fW6yMZcFMkC8t0M/9CA1Ob6GD4wZedbZjc1HWR4tRm11JOdT3v5DBO+3G5lJ4BIGtF2kXpobx8dn8FLCErpuQbyEKtvvpTo6cUX6a30y85nNnSLJqYwd+8W8ixXNlkv+HEwyrF6dx4KVgANX6vzNSLL/O4fZjVvyVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764785261; c=relaxed/simple;
	bh=rHoC/af8O31udXG/Ufd8WHfx35x+HDE4cVDsk/TD2wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AI+9nyWqt7Z7IIi/5Mev34hDamxVDH39766I/deKd1km1U6Vk3ZNdTNRCxjBNxXdVwjIKwjVFTdsRnnvXeLyvgnzrUqZU8yRVqyj+59vGG2FC3hrmU4RvB2BL8qP0vQf1ApUZsCe9h4Z2NT5vDFW28wz8cbJgRtWlk1g6BLZIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ulrc0nUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1914C4CEF5;
	Wed,  3 Dec 2025 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764785260;
	bh=rHoC/af8O31udXG/Ufd8WHfx35x+HDE4cVDsk/TD2wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ulrc0nUnWNPY5vAwA60zXvGzTeoSptq3GVg10ZZeM8lY2fAMwQiU8Jmrx7f/qgrSR
	 SVUHvRjLsxBTooBNJImRcmHSIanzUVBDwTz49kMueSh2rE1+2+0W0crukgsh2vMSx2
	 xFVrGAuXKTadRfEk59nx1EoLySALogadg9aYamHwyyuvAH9fIVcUX0I4hfBN8+FCiq
	 G4EbHpcXFqNqszENqxQ2SBfY4sZ5vtZqXy2r8mLhPCLBJTnXJxYKg3n+WIxcmXWhsj
	 XZwO85BMeWffu4YxoNPR6I1eZAdDDNvj9hJdxcF55nMWLauY8ly+OUMS2272LZltPf
	 yL9INXxkrdtug==
Date: Wed, 3 Dec 2025 10:07:38 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: [PATCH] objtool: More annotation code generation tweaks
Message-ID: <hpsfcihgqmhcdrg7pop7z73ptymakgjq7qlxrawrjxilosk43l@xikqif3ievj4>
References: <c05ff40d3383e85c3b59018ef0b3c7aaf993a60d.1764694625.git.jpoimboe@kernel.org>
 <176478003405.498.13298696533128884255.tip-bot2@tip-bot2>
 <CAHk-=wgzL-bCggZOuDU7_f-1jpjus8Oaqtek9T8GdGUexnHYkg@mail.gmail.com>
 <aTBr3ImmrJQe4G49@gmail.com>
 <CAHk-=wjc4BeSu7dHB=5AuQNWQ=sOGAuH4j0=uRwsGyiSo+m+bw@mail.gmail.com>
 <CAHk-=wgTWezdprq6eBYAv52r6JYoD_oBjouUfsbvMZqtpYjWfQ@mail.gmail.com>
 <bp6dxqsfa66txee3b7kzqgj2hgzow6ukvffczn2fz43kn53prv@2zlw65irjsc6>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bp6dxqsfa66txee3b7kzqgj2hgzow6ukvffczn2fz43kn53prv@2zlw65irjsc6>

Remove the superfluous section name quotes, and combine the longs into a
single command.

Before:

  911: .pushsection ".discard.annotate_insn", "M", @progbits, 8; .long 911b - .; .long 2; .popsection

After:

  911: .pushsection .discard.annotate_insn, "M", @progbits, 8; .long 911b - ., 2; .popsection

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/annotate.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/annotate.h b/include/linux/annotate.h
index 5efac5d4f9cf..2f1599c9e573 100644
--- a/include/linux/annotate.h
+++ b/include/linux/annotate.h
@@ -8,33 +8,32 @@
 
 #define __ASM_ANNOTATE(section, label, type)				\
 	.pushsection section, "M", @progbits, 8;			\
-	.long label - .;						\
-	.long type;							\
+	.long label - ., type;						\
 	.popsection
 
 #ifndef __ASSEMBLY__
 
 #define ASM_ANNOTATE_LABEL(label, type)					\
-	__stringify(__ASM_ANNOTATE(".discard.annotate_insn", label, type))
+	__stringify(__ASM_ANNOTATE(.discard.annotate_insn, label, type))
 
 #define ASM_ANNOTATE(type)						\
 	"911: "								\
-	__stringify(__ASM_ANNOTATE(".discard.annotate_insn", 911b, type))
+	__stringify(__ASM_ANNOTATE(.discard.annotate_insn, 911b, type))
 
 #define ASM_ANNOTATE_DATA(type)						\
 	"912: "								\
-	__stringify(__ASM_ANNOTATE(".discard.annotate_data", 912b, type))
+	__stringify(__ASM_ANNOTATE(.discard.annotate_data, 912b, type))
 
 #else /* __ASSEMBLY__ */
 
 .macro ANNOTATE type
 .Lhere_\@:
-	__ASM_ANNOTATE(".discard.annotate_insn", .Lhere_\@, \type)
+	__ASM_ANNOTATE(.discard.annotate_insn, .Lhere_\@, \type)
 .endm
 
 .macro ANNOTATE_DATA type
 .Lhere_\@:
-	__ASM_ANNOTATE(".discard.annotate_data", .Lhere_\@, \type)
+	__ASM_ANNOTATE(.discard.annotate_data, .Lhere_\@, \type)
 .endm
 
 #endif /* __ASSEMBLY__ */
-- 
2.51.1


