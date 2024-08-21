Return-Path: <linux-tip-commits+bounces-2092-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516CE95A66F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Aug 2024 23:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0913E1F22ED9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Aug 2024 21:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF141171066;
	Wed, 21 Aug 2024 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGvLYxjb"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8616EBE7;
	Wed, 21 Aug 2024 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275313; cv=none; b=htCEsmnAuwa9VZYpYNTvnRCrE6OHvllP0X7fiSDYNc0bt7XO74P9Q3tjaxPW7CuWaDrjYg/2Kmmn4JOGPVkOk5g4VTuN/gsYSltYI6baaRMNedXDmAtHbiQzawTg0y3ugYGKIQMrE10Q03AXVUMTt6T2OKotAihzeW4C0Lt7NYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275313; c=relaxed/simple;
	bh=3HZ4TSqjuK68zk7TuNaGzjlojp3FpCsb2NnbH+5J9po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTZFB9yHjD0YNtaXLtmLAdSexCXXTP89CvjZspKvJM3JPcbzmH/AXy9+tAHCaTdW80N6+O2RAnRenIWyXOblJJpOkcMus1Rs92SO6391sAM9gKBCdzt5smjyI1Ics8Kdw8zbaFrugwhk+TrKHSd5B/o96lu9repOHYJI7jvrE8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGvLYxjb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bec50de782so21309a12.1;
        Wed, 21 Aug 2024 14:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724275310; x=1724880110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HZ4TSqjuK68zk7TuNaGzjlojp3FpCsb2NnbH+5J9po=;
        b=CGvLYxjbbeqkWvnqBxPafxA/h7xuFSyW0YrlRugSPCow1PwSWn1sdVX/kk8faNPXye
         UbVzfdMnDZskbXtnIjS1c2Q4ai+CmoxOzGX+pQcb/EmAL0lUHQ8nUjoIwsLbB0QlT+IM
         7UM8LF/Q1gqWwyVCGeZCZi0cDwQZO0A86um6KoCnI+1cEqTu0v+dOsppUHIg3ZFeUfbW
         D1EmZ3FcHrTL46EFVC/BPbv307AZoeFh+dKT/JO4ilbUdjZp2ez2fTjJe5g92s7FY1A5
         fYT4nEP4Oj3cjEQNwj/lWQo8u3o2UM6uHI46bUR4ODefURCWzsg+ac0iyUmqJlqm9DKK
         Ec0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275310; x=1724880110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HZ4TSqjuK68zk7TuNaGzjlojp3FpCsb2NnbH+5J9po=;
        b=rTBeqlsUhGf9YYolDDYk5Qa1mHFG+eSyxrmOHpHQmeUMvwk283ipEGFClfZ84e199f
         W6JOHH05szdkpi63tiWwsvwM/J9TZfIeyUTWqzhzdhyCaCXCz9nGBLYRJv51RgaE0Q6+
         RDg9Or7Xuk6Cq95XKhb9iI2rlWKc2RoWoUmTysV8JVOEMImrCxSF715owXTnco+seLCk
         HypL950ZkIl3LMk09Shlhac4IOeuw/OmDAL+uV9C//I54T9d2M2psZmbLasTXLGycKQm
         oICHfuBRYay0sbdcHXk3PnPcyMvO95YH7WUHZG/b6wOhXHDFyXg5/siuXj/3exPd2tke
         +K/w==
X-Forwarded-Encrypted: i=1; AJvYcCU9z8U6kToS197eIs5sQ7mApnAzsdU+NdKKJ7RGQZnrd2YBJZ6zrOie8VXxx+CwkBkP0MgpgaI1uGWQwmqkrylsvko=@vger.kernel.org, AJvYcCUtI8B7I40iYR++CHnjjh/74CFiwVnfN7Gcb0jl3H16sbLkvnMzcM9PJj16V9obo+fmcLyD7jSqwlPAuKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz580I7H1vnWT4t9ncvWGj0V8lA5By2RBWw8YCIVY7WyU+rytMe
	6jSbZED6jClTbAPC6g5xdvIhZXxk76t0uON3chqdGCapPaHQSEPsDFzhkX8D1og=
X-Google-Smtp-Source: AGHT+IEyALFncJPq++dIHMqI7aP2pxRPueTQWabTB3Rb4Jsn2qFkrnwUMweWFN424CfM+WmR5h8ymg==
X-Received: by 2002:a17:907:9406:b0:a7a:a33e:47cd with SMTP id a640c23a62f3a-a866fa43199mr146731266b.8.1724275310155;
        Wed, 21 Aug 2024 14:21:50 -0700 (PDT)
Received: from max8rr8pad.localnet ([46.53.247.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f507facsm11757566b.225.2024.08.21.14.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:21:49 -0700 (PDT)
From: Max Ramanouski <max8rr8@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: tip-bot2 for Max Ramanouski <tip-bot2@linutronix.de>,
 linux-tip-commits@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Alistair Popple <apopple@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/urgent] x86/ioremap: Use is_ioremap_addr() in iounmap()
Date: Thu, 22 Aug 2024 00:21:49 +0300
Message-ID: <6013396.DvuYhMxLoT@max8rr8pad>
In-Reply-To: <875xrujkeu.ffs@tglx>
References:
 <20240815205606.16051-2-max8rr8@gmail.com>
 <CAJrpu5n5ReFCWrtAYsWpneAb+g6hAs4E-NeFh40chJfArEsioQ@mail.gmail.com>
 <875xrujkeu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> Please do not top-post and trim your replies.

Sorry, got a bit distracted and forgot to remove the default gmail
reply text. Will try to be more careful in future with better email
client.

> Careful, this might end up with other issues vs. the kernel header
> inclusion hell.
> If i386 is the only one which does not have VMALLOC start in
> asm/pgtable.h, then curing this might be the easier fix, no?

I thought about that initially, but then found out that apparently
it is like that for a reason. In commit:

186525bd6b8 ("mm, x86/mm: Untangle address space layout definitions from basic pgtable type definitions")

VMALLOC_START definition was specifically moved out of pgtable
related headers. But for some reason only for 32 bit arch. Plus
I think asm/vmalloc.h is more semantically correct to get
VMALLOC_START. Although on most arches (everywhere except x86,
arm64, powerpc and riscv) asm/vmalloc.h is an empty header. And
on riscv it doesn't actually provide VMALLOC_START... Probably
that is worth a separate fix later.

Best regards,
Max




