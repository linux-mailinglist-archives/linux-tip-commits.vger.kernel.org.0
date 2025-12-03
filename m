Return-Path: <linux-tip-commits+bounces-7584-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6F6CA0C01
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 19:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4FAC13006E12
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83B53161AF;
	Wed,  3 Dec 2025 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CbJ6GqQQ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BB330C619
	for <linux-tip-commits@vger.kernel.org>; Wed,  3 Dec 2025 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764783906; cv=none; b=phJGC5IVdfVLZoMJJtuCxyidtHLydwRwcGpGByolPCeQeB+3E+YUJFus2TRW8dDZU3i2sXBNHmVGmj3GUXr23rP2NJkDXlZQR1rZ3sV7rXDnTYmq1cqCi2JZGtheF5w7utDZFl73w9SustIrM8vkwzo6ljlZDFbCWVV7X688W1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764783906; c=relaxed/simple;
	bh=ivGEDE5oOEvKm1xY3Rk3hgNOaXYaAse63rCpmgdZfug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+AIU1sSJUSdlfpHb+eKapoW4rTw+FBkFUy0Uwq09kVHCGcbH95kqCXeZKWi2Si9CeCgmT7OOfrwU1Pjq2I4kF29v7sddWKkoD3MauxKPI7rW/0Mv6K/nEuBZMETGCkcAq4YjXHIG3jKx1EbUu3rqbGYTlsCeLMPHwZQeodXrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CbJ6GqQQ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so9086214a12.0
        for <linux-tip-commits@vger.kernel.org>; Wed, 03 Dec 2025 09:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764783903; x=1765388703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a7AC1fjGPhRI8jv6LTd9Dz4WyZ+JQOqk9zt4lgWdTgU=;
        b=CbJ6GqQQvWVBzbNm4q1MtN1aBuzk1KGxAGv0CZzT1tVUkJaAdIGaUj84HQ4ec6e0ed
         fVfxVGgKQiXEeSt/WUN2fP++b+4+maMdyWK2n44/UAxVMM6/hrgeyB3MpFpFOjTu03v3
         Qwp9UD0yevlql8U6ATnpr21bs+QeBaTXL2tMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764783903; x=1765388703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7AC1fjGPhRI8jv6LTd9Dz4WyZ+JQOqk9zt4lgWdTgU=;
        b=kmPD3TTWepEXtOQG4tenPa37F3YtcyIbT+AfgAcRdwElvGf+DmDNHbsVGzKpkBUchs
         rO+kiFGZKWmu7x6Uoy67Z+5ii7B291Yi5kExeTr48YyzswL12qomCGaMGqlh4yUzQIUm
         F6m8aST3AB6g0Oy7f10p12jXAnNFTtYB6Lel+NMeOFX+fpR6McSZY63IT0LA/IstudaC
         EriFoEAsAe1vC7wLB6IqqDlqF4g8TpUfyhvy17n3mRp46/zQxBrf1wRAH3PSJ2CocjJi
         VtqTcmLOyu22e6ewbCGCfzb0jo4klSKgvj65G/Bp+0hDbpwxFD4DGh7c9Z8zAe+nMOpJ
         eFSA==
X-Forwarded-Encrypted: i=1; AJvYcCUoFPYljrLJjMBIGgA2GQZC9c1fY9phYWD0GBX/5pDc4RsUGY7y46vvi7MGf+z0atfyfd6XAfi/mOk9BIhxTFtHcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWtA16qQkKF4+sw3L+5vI8LajeOpEqM/ZunznPyrFQa17Qq1hq
	bGZjGuTIRaStqp8fTtFXEj4ZcOsnoqXRVD5qKEo7ViUQUBWfChS8/5fVhN++e7gPz4vwy0ifp4Z
	M+dMRUGI=
X-Gm-Gg: ASbGncuQNll2p3AgfpO0harGOHALPFsSP6XWGhoX0T8umPipT90eJ8xiQENMGIBzYfa
	9xRY3AwvVbGYu3OyhHu6QjSixlvbYfUc/+6dvn1YzgVhuJPh0bOzs3QX9KL9HclsAcPHqFuvLJk
	FB7DqTQ94lYxZsJ87aBrun2i8kfaV2in+sspqCNKboawokbQwJN94VNsLk+lqCdjJUi/CtMz5Yp
	T+rtDXaoaR7cmNi5QfxCPfOqd71soNsluj40Y746y9Gdf132ucdxjc1FIrMuSmT1upmPMMBKShy
	3CwofKLdnI0qqiq5RDoZgHv+hX3Dfc5Y/zi1syG9QzCOq1Ex8KjizFKMdA90buS6WeD/MfOg/7j
	Pu1n5b5ItV4uO4f7DdZbIJD541iO0ERKH89RdDh99mLcww4SZuss8W20LOVRinYvGrxqg8zbI4U
	YjVPHum4/8wbNu03gmBkZM5zzw9+3OWSa9KDfUF1DbCqNcyl47bm8YR1vIYUDFAr+uxiV13MI=
X-Google-Smtp-Source: AGHT+IE6AANUo8K35VEbkQUtWTJGSbfDZT4uGJQlvytyS+/Z/OJjT5J8y8zgW5E94gRGGgr7McsbTg==
X-Received: by 2002:a05:6402:2111:b0:640:f481:984 with SMTP id 4fb4d7f45d1cf-6479c3ed696mr2639022a12.2.1764783902809;
        Wed, 03 Dec 2025 09:45:02 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751035c2fsm18935830a12.17.2025.12.03.09.45.02
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 09:45:02 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so10376781a12.2
        for <linux-tip-commits@vger.kernel.org>; Wed, 03 Dec 2025 09:45:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVoFPZDQTXjaVC9O84wOUyvYj8tlpjiOChAUW4qqE86jBqVt7Siza5zC29wxwKC9o0yvIEd0wDGvxe0dKjUTo1vHg==@vger.kernel.org
X-Received: by 2002:a05:6402:254b:b0:640:b31a:8439 with SMTP id
 4fb4d7f45d1cf-6479c415686mr2908225a12.12.1764783901731; Wed, 03 Dec 2025
 09:45:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c05ff40d3383e85c3b59018ef0b3c7aaf993a60d.1764694625.git.jpoimboe@kernel.org>
 <176478003405.498.13298696533128884255.tip-bot2@tip-bot2> <CAHk-=wgzL-bCggZOuDU7_f-1jpjus8Oaqtek9T8GdGUexnHYkg@mail.gmail.com>
 <aTBr3ImmrJQe4G49@gmail.com> <CAHk-=wjc4BeSu7dHB=5AuQNWQ=sOGAuH4j0=uRwsGyiSo+m+bw@mail.gmail.com>
In-Reply-To: <CAHk-=wjc4BeSu7dHB=5AuQNWQ=sOGAuH4j0=uRwsGyiSo+m+bw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Dec 2025 09:44:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTWezdprq6eBYAv52r6JYoD_oBjouUfsbvMZqtpYjWfQ@mail.gmail.com>
X-Gm-Features: AWmQ_blDJJkWbllvBLW3gVbK7ReojIOuBWSy-u-DWjNR8cOoKE6afqURElEiNQA
Message-ID: <CAHk-=wgTWezdprq6eBYAv52r6JYoD_oBjouUfsbvMZqtpYjWfQ@mail.gmail.com>
Subject: Re: [tip: objtool/urgent] objtool: Consolidate annotation macros
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Dec 2025 at 09:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It *feels* like this should just all be
>
>         911: .pushsection .discard.annotate_insn ; .long 911b - .; .long 1; .popsection
>         jmp __x86_return_thunk
>
> instead.

Actually, I think it should just be

  911: jmp __x86_return_thunk
  .pushsection .discard.annotate_insn ; .long 911b - . , 1; .popsection

but again: it's entirely possible that there's something I am missing.

           Linus

