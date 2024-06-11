Return-Path: <linux-tip-commits+bounces-1378-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9126390479E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 01:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC621C23805
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 23:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBDD155A5D;
	Tue, 11 Jun 2024 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FGESD/hC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wC3VR5m0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F281015383E;
	Tue, 11 Jun 2024 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718148103; cv=none; b=HcpL4Nf+c7hTeDqQnPPor7iKhGOZ7ej+sAqLXAN4Kp2/x0oRnNXBF19Jc5HJMx6elfbPlgCF1MueNgHo/GpNgfmdyasCnXIbNRR5dVqsHZP8FVVdRgyugxIFNpFfJGrwDUuZiOeiE1hjaAo0uDCyoQR0QW6aUIxr0qzksiRyz+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718148103; c=relaxed/simple;
	bh=lgcvT1LFguPIGLAYYDYCpNfwqmbxvFvBkVmTRkjKdRI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oL8tHfEk2oVOKZlg12uI1eHcmD8i6LY7uW2TzaJzVJYfL9FySxKnE+W1SGFYurwTcKpoIehttjCTG1AMJ3emmh8NMyi+kPIatX4PlEZNI0WkNNv4fhd/rYmk88Qnup3s0unVfKSOqKsCNcULgOE0KgvaQlPmlPmiLAMHVsEgm/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FGESD/hC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wC3VR5m0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Jun 2024 23:21:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718148099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1nMsl9Pleiu2nnrNLuo1//XOiGGLzSSKOjxP3hiMmcI=;
	b=FGESD/hCmZSs/Sjl34/TmVYmEpuGeXd7MI1+W7DLIbnm3JhWxAzsEWBI/DIUdEWq0KWc1U
	9JXi4jYALHOvFTPm4bZY5dIQKN4K3X+AUKGN+PH0lQt53JcvoGP+21BBNiLTsaGb60n8rT
	FNOiTVYB71ms5sH+6VGNt6vsrHKAAxKuQQiSau6v+12caqPhouOcxE6toaDbf1ymY6Sl8C
	mOrTwj9gsFrjS6KkenPxHp7stzI/UzQGPZ9UcPXCrw7ifKGramBzQwMeqv4aJ2W0KVWxIj
	v8NfGuViOFPdZJP+qM5ASVRT1qzLek6sRx+M6A+yHlTR3yABnryd/UEnwVevOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718148099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1nMsl9Pleiu2nnrNLuo1//XOiGGLzSSKOjxP3hiMmcI=;
	b=wC3VR5m0sH6cKcvUG8FEtbJtZtp5T0d3ci0bMfxRUyWuGx/iH7gwqPgm3/4YdR6/4e8P7t
	xgagbgvkhwMYcQBw==
From: "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/uaccess: Fix missed zeroing of ia32 u64
 get_user() range checking
Cc: David Gow <davidgow@google.com>, Kees Cook <kees@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171814809836.10875.16192775250585281256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8c860ed825cb85f6672cd7b10a8f33e3498a7c81
Gitweb:        https://git.kernel.org/tip/8c860ed825cb85f6672cd7b10a8f33e3498a7c81
Author:        Kees Cook <kees@kernel.org>
AuthorDate:    Mon, 10 Jun 2024 14:02:27 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 11 Jun 2024 16:08:43 -07:00

x86/uaccess: Fix missed zeroing of ia32 u64 get_user() range checking

When reworking the range checking for get_user(), the get_user_8() case
on 32-bit wasn't zeroing the high register. (The jump to bad_get_user_8
was accidentally dropped.) Restore the correct error handling
destination (and rename the jump to using the expected ".L" prefix).

While here, switch to using a named argument ("size") for the call
template ("%c4" to "%c[size]") as already used in the other call
templates in this file.

Found after moving the usercopy selftests to KUnit:

      # usercopy_test_invalid: EXPECTATION FAILED at
      lib/usercopy_kunit.c:278
      Expected val_u64 == 0, but
          val_u64 == -60129542144 (0xfffffff200000000)

Closes: https://lore.kernel.org/all/CABVgOSn=tb=Lj9SxHuT4_9MTjjKVxsq-ikdXC4kGHO4CfKVmGQ@mail.gmail.com
Fixes: b19b74bc99b1 ("x86/mm: Rework address range check in get_user() and put_user()")
Reported-by: David Gow <davidgow@google.com>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: David Gow <davidgow@google.com>
Link: https://lore.kernel.org/all/20240610210213.work.143-kees%40kernel.org
---
 arch/x86/include/asm/uaccess.h | 4 ++--
 arch/x86/lib/getuser.S         | 6 +++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 0f9bab9..3a7755c 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -78,10 +78,10 @@ extern int __get_user_bad(void);
 	int __ret_gu;							\
 	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);		\
 	__chk_user_ptr(ptr);						\
-	asm volatile("call __" #fn "_%c4"				\
+	asm volatile("call __" #fn "_%c[size]"				\
 		     : "=a" (__ret_gu), "=r" (__val_gu),		\
 			ASM_CALL_CONSTRAINT				\
-		     : "0" (ptr), "i" (sizeof(*(ptr))));		\
+		     : "0" (ptr), [size] "i" (sizeof(*(ptr))));		\
 	instrument_get_user(__val_gu);					\
 	(x) = (__force __typeof__(*(ptr))) __val_gu;			\
 	__builtin_expect(__ret_gu, 0);					\
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 10d5ed8..a1cb3a4 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -44,7 +44,11 @@
 	or %rdx, %rax
 .else
 	cmp $TASK_SIZE_MAX-\size+1, %eax
+.if \size != 8
 	jae .Lbad_get_user
+.else
+	jae .Lbad_get_user_8
+.endif
 	sbb %edx, %edx		/* array_index_mask_nospec() */
 	and %edx, %eax
 .endif
@@ -154,7 +158,7 @@ SYM_CODE_END(__get_user_handle_exception)
 #ifdef CONFIG_X86_32
 SYM_CODE_START_LOCAL(__get_user_8_handle_exception)
 	ASM_CLAC
-bad_get_user_8:
+.Lbad_get_user_8:
 	xor %edx,%edx
 	xor %ecx,%ecx
 	mov $(-EFAULT),%_ASM_AX

