Return-Path: <linux-tip-commits+bounces-6929-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C08BE2A1E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBCC5832EA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD3F340D86;
	Thu, 16 Oct 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="usSb6PFQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TBd+QQ3f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FEE338F5F;
	Thu, 16 Oct 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608422; cv=none; b=VAGxvsgjDA9VHbOByKXiL0R4aUfx13SPmKH99aWRxjalS2vyQ4fWj+aBmGbqe3uMEkEGwdKZBpffvtSdXHYnTIAXY3dbT6ooCSHx3jcIudT2nJ4Z1OkntzHWNfBwUBj+8Y5WlxTvZT8FsFSDX+QtP+EQFYiIui8EBAvHgfOT0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608422; c=relaxed/simple;
	bh=lJr70iuuDVKauXQJ9U4Y/CeniupY9zF6/iKl/zEXQug=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=mrjE9QL+lPp2KSBHg8St6k9yZzJC1NnWiJXJmTNpf0N2Ge2UaIJWzEqYdRHQ6TFHr63i2BeGpnkubxVqvEx0ObkQg9mRXEyw54D32xYF43a3Z4K7iKpKDmDwp/gCHw6MWcBNMBCycSC0rJEHk9P+5dfKYNogcxRa2zWMYP4NjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=usSb6PFQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TBd+QQ3f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608403;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vw7RzR1F+J+g6CjG/1pNgdfnXz2xBRuwE+0Slq52lrw=;
	b=usSb6PFQj1zYt4QmR8OABE5S1yi06bzGaYgIyzzA6AAyovpb/PB+OxxN5SvDYBvsqb0Zp3
	78zhbubclqn1sa43E49wQFVs8qw8f5tW2qXoTzWhZ3sP3WnGHk1OKrLuzcygN22Y25hw3R
	DQzJV/qxnls7833N6w8iuc8eltS5Vxv8UTdxFL2vHUqRmQ7CdqRYkkL3ZLjs7IEP0k+2RE
	RxDAE+peEMTZnrPuvrE5cSDYHz0EK3eVrAcV+Iowx9POHsNj4cP7sPwc6nWDBLi4QxmVhE
	HopgNrc8tGnHCkjZ2h+GY+6SoaHe/YDpwZWHuPxw5JYjHXvWFoXzrF1X8+bKFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608403;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vw7RzR1F+J+g6CjG/1pNgdfnXz2xBRuwE+0Slq52lrw=;
	b=TBd+QQ3fpxzhGCqzd0P5O34PgXlovIcKKK8I6PWlSHRNeIPWB9kTAhFPQSst7j/wkUq/t2
	j16o+lOltNC+dfCQ==
From: "tip-bot2 for Pankaj Raghav" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] scripts/faddr2line: Fix "Argument list too long" error
Cc: Pankaj Raghav <p.raghav@samsung.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060840170.709179.14105443112485527789.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ff5c0466486ba8d07ab2700380e8fd6d5344b4e9
Gitweb:        https://git.kernel.org/tip/ff5c0466486ba8d07ab2700380e8fd6d534=
4b4e9
Author:        Pankaj Raghav <p.raghav@samsung.com>
AuthorDate:    Sun, 21 Sep 2025 12:03:58 +02:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:20 -07:00

scripts/faddr2line: Fix "Argument list too long" error

The run_readelf() function reads the entire output of readelf into a
single shell variable. For large object files with extensive debug
information, the size of this variable can exceed the system's
command-line argument length limit.

When this variable is subsequently passed to sed via `echo "${out}"`, it
triggers an "Argument list too long" error, causing the script to fail.

Fix this by redirecting the output of readelf to a temporary file
instead of a variable. The sed commands are then modified to read from
this file, avoiding the argument length limitation entirely.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/faddr2line | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 7746d4a..6228753 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -111,14 +111,19 @@ find_dir_prefix() {
=20
 run_readelf() {
 	local objfile=3D$1
-	local out=3D$(${READELF} --file-header --section-headers --symbols --wide $=
objfile)
+	local tmpfile
+	tmpfile=3D$(mktemp)
+
+	${READELF} --file-header --section-headers --symbols --wide "$objfile" > "$=
tmpfile"
=20
 	# This assumes that readelf first prints the file header, then the section =
headers, then the symbols.
 	# Note: It seems that GNU readelf does not prefix section headers with the =
"There are X section headers"
 	# line when multiple options are given, so let's also match with the "Secti=
on Headers:" line.
-	ELF_FILEHEADER=3D$(echo "${out}" | sed -n '/There are [0-9]* section header=
s, starting at offset\|Section Headers:/q;p')
-	ELF_SECHEADERS=3D$(echo "${out}" | sed -n '/There are [0-9]* section header=
s, starting at offset\|Section Headers:/,$p' | sed -n '/Symbol table .* conta=
ins [0-9]* entries:/q;p')
-	ELF_SYMS=3D$(echo "${out}" | sed -n '/Symbol table .* contains [0-9]* entri=
es:/,$p')
+	ELF_FILEHEADER=3D$(sed -n '/There are [0-9]* section headers, starting at o=
ffset\|Section Headers:/q;p' "$tmpfile")
+	ELF_SECHEADERS=3D$(sed -n '/There are [0-9]* section headers, starting at o=
ffset\|Section Headers:/,$p' "$tmpfile" | sed -n '/Symbol table .* contains [=
0-9]* entries:/q;p')
+	ELF_SYMS=3D$(sed -n '/Symbol table .* contains [0-9]* entries:/,$p' "$tmpfi=
le")
+
+	rm -f -- "$tmpfile"
 }
=20
 check_vmlinux() {

