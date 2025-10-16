Return-Path: <linux-tip-commits+bounces-6932-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC75BE29A6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49D8C4FBA05
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 10:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C60F340D9B;
	Thu, 16 Oct 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wl88FBNq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O7x09/X/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADA333A02C;
	Thu, 16 Oct 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608427; cv=none; b=tIDe/fsrVHBHUMwlhbEg5vKT/ISa1ofcRjUwyjEZnCUbk84CLI0p8ZJEqK8qIKL5xWW7W1W5Q5uxayc2Bomf8yGjhkEiaK8IKOghqNr8gWFyfegM4X5/U8CTZQ+PTRr0pOVDPfHmcizbTpuDo6X4pKAKQ7S8tnIf6j8zIi2FZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608427; c=relaxed/simple;
	bh=kuPknXr82GD3/Wx7zM67E6Ecz5h3qI6MMmY7hLGZXzc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=SEyJNH9kv3Uq6VxzKrjeqdzej7lHZ1ZM08Evvsop4ndVTqMbdZr+QEYwCRmvMIlTdZhmNFNIhLUkY+e1+5H/yhDK0x+izmiRJnM5+JsBgHUVbjhZq2pkl1fFcWhvDXFVPcKG8fRyH/k0gEkxiBH8zzy43wNORETUtsTcvJlUyaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wl88FBNq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O7x09/X/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608407;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=M2PFjNX+BdyQFQpOaD2iSsTZ4xwCs8AqVN0kZQZmSws=;
	b=Wl88FBNqFfwZfgFBfmkUE+6Ux0/YGfbXp7HfptWe0Zd9yQWSQJxCLEoeCRW1Q/yTNGUI2H
	nkgtMQ+NUy0brBOzozjvVTFSK8RGJ1MERlkKn/Dd677zogiuiWJEWgswxffBCkaA12fROX
	WI9I83FkpqtsX/XXx5wEBhFv23SHOf8o2jFVAVgb0DR2+tmEP6jWQlKL905NGYBIip7VjS
	j3N7htqoJ0EQw6ve5c0YOxsn4ZN4CYCFBnwZyyX84HVcPpoK39Oo/StI4a4XChukI5Nw/V
	M1ZO/7k/wttP1DIzzGBERy9VZu+ZWsd13NM4V1kVvW24U2szOWj19QOv7Ms1PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608407;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=M2PFjNX+BdyQFQpOaD2iSsTZ4xwCs8AqVN0kZQZmSws=;
	b=O7x09/X/BeUi1WEyhaqamJpGKLSUv8njbjJuCADi/fupoBTQ1fguBziE1yOK1Ew9m41G13
	FZs35E0WfLZyx1CQ==
From: "tip-bot2 for Chen Ni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove unneeded semicolon
Cc: Chen Ni <nichen@iscas.ac.cn>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060840619.709179.13325327134027948102.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2e985fdb7e54293695a2a386e06e59d441efbe0f
Gitweb:        https://git.kernel.org/tip/2e985fdb7e54293695a2a386e06e59d441e=
fbe0f
Author:        Chen Ni <nichen@iscas.ac.cn>
AuthorDate:    Mon, 07 Apr 2025 15:54:05 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:20 -07:00

objtool: Remove unneeded semicolon

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 0f6b197..fcd4a65 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -243,7 +243,7 @@ static void save_argv(int argc, const char **argv)
 			ERROR_GLIBC("strdup(%s)", argv[i]);
 			exit(1);
 		}
-	};
+	}
 }
=20
 void print_args(void)

