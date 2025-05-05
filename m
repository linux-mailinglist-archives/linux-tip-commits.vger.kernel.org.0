Return-Path: <linux-tip-commits+bounces-5250-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1255AA99D8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 18:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C953B4EF0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7059226A08C;
	Mon,  5 May 2025 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CzIN5Ynh"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9707A26B0BE
	for <linux-tip-commits@vger.kernel.org>; Mon,  5 May 2025 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464199; cv=none; b=SGgag6lGsf3QPBzy1OW11KMLAzdUyGhDlp+2U07cMZCVbb6KAmmUuAIjtLKSau2zfQ+y+h2Y/a96It0trgM5la0gylp88Pk+8tq9M8UGLEPPOqAOBZI3y5YfW2qo86Ogx75Gp4+k/9ZMnfHUmdgdQioZ47e4WBva6vJXNvANIqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464199; c=relaxed/simple;
	bh=LjecaitHCbUwnqHRviSWLEw3xl0kwb7JmL/lsRMW4pw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UXj0EMzblCGABZV7GGP4cL9V1qP4INa7vkonqz2jvlAD2SmCcCy48SL17hUPI1EXqRfgzpgE3+7lCz6qRseVfIuSeOfVQckmXveYdNBxUDheMcVxkwMMsVKgCCVkTsGBJvIN1oGZJTEjQDSlxBsukgbPH8gCTOWzBHFTEChmp50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CzIN5Ynh; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5faa649b22bso2163416a12.3
        for <linux-tip-commits@vger.kernel.org>; Mon, 05 May 2025 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746464196; x=1747068996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CMd8wRcjjQeiU6qBCa3iVhXFCPz/wm9uismZwGYnVJ8=;
        b=CzIN5Ynh1A+wHkZ6zUEOeE0d8U7/GR6kkGeoktlBm5xYnw4DNz86oBST6REX7Y/uTa
         mkb5FvhZwRxqecT3IkX8JBY4EzZcsav1a4ORWGZaDwLSNvUOmWQCW9E7sWNHAoyt9k3T
         M8hM+mz/pnwpGK5o7IhHCjFJhfky4mb8n6CL76weBbXA+NXDyHakYPUa7gIvnFEMbiFN
         G0BDK3lRhh6jHL4/DcN0MEmB6vNvSfbXm8C5OmhBl+nItn3Csj1+QjjviXGHnSRaana9
         pnh3LofdQlXpTTkeYXqUUixlTlVZNRCS1DUQLC6xrhHW5DNbSJgLkkjMypS45fkRUjNm
         /Ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746464196; x=1747068996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMd8wRcjjQeiU6qBCa3iVhXFCPz/wm9uismZwGYnVJ8=;
        b=Htyv9KGVDnK3iAcae4w5QSn3qvJTQ0FoQJiZL/lIGTSu6lPQxGSn2GPvcMPH68afVe
         v134kMMgbUli6vKl67mECJDRsVqZf3W1k3oHqqvNdownBoJBvbGAq09P8Bl00kftE5GU
         BINdi6+KMJXNwgg0RtOGKOAXu6fmDWb53dG/xsCycU0ea/O2gUSNE9i/f3xVyEGXa6EO
         F0OrOqZQHzNH7Ji6MfBHGJTYkBr6oUpfzJTyiiTGdYVi+ZA75OO+m0nOMEzYITQWGwba
         VKvKjJYYLiZ0hHs3UFsGN6xtvA/Moq0Io0qD4h4zwOc+gWwehIYKigutlrV8hWusYw6p
         9l4w==
X-Forwarded-Encrypted: i=1; AJvYcCVniQ79dBnODzUvCSle9D7lpMdBGwihQhdDd4BNgKFZLipwcTHSZ7LwFt7FyOVVvRcvapeH3ozzvsWoVh4MZOB1LA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9o9KSkTAJP7uKBhRnfECwsPhi4mjda5dUSjFoIPtc6K1AIyUG
	eKq1bhYYHYQXVM/xUMxV4AcayNE0db4+acXeqVuAGnsYgvuniuGR9D4cPpx8CO4pwCoJcwuktxK
	aFQ==
X-Google-Smtp-Source: AGHT+IEBcfevoOYUkLLzoks1g6vqsYC5+N82Ie6uuEocKObQ+WVhUs2GJObf+yQ4S/JbiEIGZp2jNSe06Is=
X-Received: from edbfd21.prod.google.com ([2002:a05:6402:3895:b0:5f9:1a8a:197b])
 (user=nogikh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:2755:b0:5fa:afdf:1413
 with SMTP id 4fb4d7f45d1cf-5faafdf14c7mr6599862a12.6.1746464195897; Mon, 05
 May 2025 09:56:35 -0700 (PDT)
Date: Mon,  5 May 2025 18:56:33 +0200
In-Reply-To: <174489496807.31282.14803836540166615145.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <174489496807.31282.14803836540166615145.tip-bot2@tip-bot2>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250505165633.3892723-1-nogikh@google.com>
Subject: Re: [tip: x86/alternatives] x86/mm: Remove the mm_cpumask(prev)
 warning from switch_mm_irqs_off()
From: Aleksandr Nogikh <nogikh@google.com>
To: tip-bot2@linutronix.de
Cc: andrew.cooper3@citrix.com, bp@alien8.de, brgerst@gmail.com, hpa@zytor.com, 
	jgross@suse.com, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, luto@kernel.org, mingo@kernel.org, 
	peterz@infradead.org, riel@surriel.com, 
	syzbot+c2537ce72a879a38113e@syzkaller.appspotmail.com, 
	torvalds@linux-foundation.org, x86@kernel.org, 
	syzkaller-bugs@googlegroups.com, dvyukov@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Peter, Ingo,

Thanks for addressing the problem!

It's been a couple of weeks since the commit has been merged into
x86/alternatives. However, it doesn't appear to be in linux-next yet,
which unfortunately prevents syzbot from fuzzing the linux-next tree.

When could we expect the commit to reach linux-next? If it's possible
to get it there sooner, that would be much appreciated.

Thanks,
Aleksandr

On Thu, 17 Apr 2025 13:02:48 -0000 tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de> wrote:
> The following commit has been merged into the x86/alternatives branch of tip:
> 
> Commit-ID:     52ebfe7412ce4b3af54fe962af58efe9b25cd9a9
> Gitweb:        https://git.kernel.org/tip/52ebfe7412ce4b3af54fe962af58efe9b25cd9a9
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Thu, 17 Apr 2025 14:34:13 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Thu, 17 Apr 2025 14:46:25 +02:00
> 
> x86/mm: Remove the mm_cpumask(prev) warning from switch_mm_irqs_off()
> 

