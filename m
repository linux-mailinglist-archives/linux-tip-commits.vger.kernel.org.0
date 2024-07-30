Return-Path: <linux-tip-commits+bounces-1812-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FB7940A78
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 09:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32314B24926
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 07:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2C41922D7;
	Tue, 30 Jul 2024 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfMQnBUd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C571922D0;
	Tue, 30 Jul 2024 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326168; cv=none; b=WE0q8cb4UwYwhHx5aBV+MsOVzmY1U1F5oGflTFYjSrsdMlxqt7CHFZffHnjReUjKxE14MmDTsD4I0XmZHvoeCaKi9//6sCcvbGqFM4C+tNLqn4O0n3XagAM8XJiDvnedmWJ7uWO1YAqTBpj7XJHF8tB+hSWicuqdGQ7Vqcp6j9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326168; c=relaxed/simple;
	bh=Oxb3+9POPgRRPmdnvmiri4xP1ANzqB1A7za7uLZ+riE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fdu6BHvZ2t5rC9Uk7jNwXgh6C6uMqvHuoR9X855+sOxO79KGJYULLKFoY7VILjC4VcCN+MdA7WW4XTJOA/lS8x2Tt1cktty20vAgZfeF2LwdqitYxmbrtx57Ex88k/SV6f39G5mbAT2antk4fq6pcqtQW0tM57Sn7cNM58msbeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfMQnBUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B65C32782;
	Tue, 30 Jul 2024 07:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722326168;
	bh=Oxb3+9POPgRRPmdnvmiri4xP1ANzqB1A7za7uLZ+riE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WfMQnBUdNcYRvkPAKw2JMQ78ChPfzJ5kzCQ8ex1qJCARJDiVCAxJa/gCjGTtKpZcS
	 TquSXgiMLGgj79aKJz1bN4bbTx7RaLmsbJBGi+4nCMIa9ILARHF2z/LqPU25+IYpts
	 FV7xP0PFnn7SBNNx6NiaZBxDc9C1hsIZTrMbnjxxxgd26069KtBdH3dw2VuFPcxeJF
	 tXsEtGRrVgpdCmSNLdUVZnE7beEYIIFDnIg+GQAxtJ5hc9NyLnVRU5Pg56zqx2GQKb
	 ldeVeBko9FhVJ1fUqbRvtnqzS1Th+wM/qJ9YGQMYKyXOwacKzYuUh2FPnJF/JT2a5V
	 LVeb88nz8znTg==
Date: Tue, 30 Jul 2024 09:56:04 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	kabel@kernel.org
Subject: Re: [tip: irq/core] irqchip/armada-370-xp: Change symbol prefixes to
 mpic
Message-ID: <z3vgu5vimj5wkcvlxs27y5s7q3epvmtgrtb7zovdfojpregcye@pqdxzesipb36>
References: <20240711115748.30268-7-kabel@kernel.org>
 <172224658404.2215.1380801249029241672.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172224658404.2215.1380801249029241672.tip-bot2@tip-bot2>

Hi Thomas,

so I am going through the differences of the commits that you applied
in contrast to the originals that I sent, as you asked.

This commit is rather large, so understandably there was a larger
probability for a mistake. It seems ok, but I have the notes:

>  	if (WARN_ON(!base_ipi))
>  		return;
> -
>  	set_smp_ipi_range(base_ipi, IPI_DOORBELL_END);
>  }

^^ I did not remove this line in my original patch, I always try to
leave an empty line after conditional return:
  if (cond)
    return;
  // empty line
  code;

I guess this is not an issue, though.

> @@ -704,62 +687,60 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
>  			int ipi;
>  
>  			ipimask = readl_relaxed(per_cpu_int_base + MPIC_IN_DRBEL_CAUSE) &
> -						IPI_DOORBELL_MASK;
> +				  IPI_DOORBELL_MASK;
>  

^^ This change also was not in my original patch. I would have put this
into the "improve indentation" commit, instead of the one that "changes
symbol prefixes to mpic_", since semantically it belongs into the first
one.

IMO it would have been better to leave these patches as they are, and
do the change to 100 columns in a subsequent patch, all in one, since
there are many other parts of the code that would have benefited from
it. And you would not need to spend time going through the patches line
by line :-)

Anyway, this patch seems ok.

Marek

